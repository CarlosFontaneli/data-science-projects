import streamlit as st
import pandas as pd
import numpy as np
import pydeck as pdk
import plotly.express as px

DATA_URL = "./Motor_Vehicle_Collisions_-_Crashes.csv"

st.title("Motor Vehicle Collisions in New York City")
st.markdown("This application is a Streamlit dashboard to analyze crash collisions 🚓")


@st.cache_data(persist=True)
def load_data(nrows):
    data = pd.read_csv(
        DATA_URL, nrows=nrows, parse_dates=[["CRASH_DATE", "CRASH_TIME"]]
    )
    data.dropna(subset=["LATITUDE", "LONGITUDE"], inplace=True)
    lowercase = lambda x: str(x).lower()
    data.rename(lowercase, axis="columns", inplace=True)
    data.rename(columns={"crash_date_crash_time": "date/time"}, inplace=True)
    return data


data = load_data(100000)

st.sidebar.header("Filter by Date Range")
start_date = st.sidebar.date_input("Start date", data["date/time"].min().date())
end_date = st.sidebar.date_input("End date", data["date/time"].max().date())
data = data[
    (data["date/time"].dt.date >= start_date) & (data["date/time"].dt.date <= end_date)
]

st.sidebar.header("Filter by Time of Day")
start_time = st.sidebar.time_input("Start time", value=pd.to_datetime("00:00").time())
end_time = st.sidebar.time_input("End time", value=pd.to_datetime("23:59").time())
data = data[
    (data["date/time"].dt.time >= start_time) & (data["date/time"].dt.time <= end_time)
]


original_data = data
st.header("Where are the most people injured in NYC?")
injured_people = st.slider("Number of persons injured in vehicle collisions", 0, 19)
st.map(
    data.query("injured_persons >= @injured_people")[["latitude", "longitude"]].dropna(
        how="any"
    )
)

st.sidebar.header("Filter by Borough")
boroughs = data["borough"].dropna().unique()
selected_borough = st.sidebar.selectbox("Select a borough", boroughs)
data = data[data["borough"] == selected_borough]

st.sidebar.header("Filter by Collision Severity")
min_injured = st.sidebar.slider(
    "Minimum number of persons injured", 0.0, data["injured_persons"].max(), 1.0
)
data = data[data["injured_persons"] >= min_injured]


st.header("How many collisions occur during a given time of day?")
hour = st.slider("Hour to look at", 0, 23)
data = data[data["date/time"].dt.hour == hour]

st.markdown("Vehicle collisions between %i:00 and %i:00" % (hour, (hour + 1) % 24))


midpoint = (np.average(data["latitude"]), np.average(data["longitude"]))
st.write(
    pdk.Deck(
        map_style="mapbox://style/mapbox/light-v9",
        initial_view_state={
            "latitude": midpoint[0],
            "longitude": midpoint[1],
            "zoom": 11,
            "pitch": 50,
        },
        layers=[
            pdk.Layer(
                "HexagonLayer",
                data=data[["date/time", "latitude", "longitude"]],
                get_position=["longitude", "latitude"],
                radius=100,
                extruded=True,
                pickable=True,
                elevation_scale=4,
                elevation_range=[0, 1000],
            )
        ],
    )
)

st.subheader("Breakdown by minute between %i:00 and %i:00" % (hour, (hour + 1) % 24))
filtered = data[
    (data["date/time"].dt.hour >= hour) & (data["date/time"].dt.hour < (hour + 1))
]

hist = np.histogram(filtered["date/time"].dt.minute, bins=60, range=(0, 60))[0]
chart_data = pd.DataFrame({"minute": range(60), "crashes": hist})
fig = px.bar(
    chart_data, x="minute", y="crashes", hover_data=["minute", "crashes"], height=400
)
st.write(fig)

st.header("Top 10 dangerous streets by affected type")
select = st.selectbox(
    "Affected type of people", ["Pedestrians", "Cyclists", "Motorists"]
)

if select == "Pedestrians":
    st.write(
        original_data.query("injured_pedestrians >= 1")[
            ["on_street_name", "injured_pedestrians"]
        ]
        .sort_values(by=["injured_pedestrians"], ascending=False)
        .dropna(how="any")[:10]
    )

elif select == "Cyclists":
    st.write(
        original_data.query("injured_cyclists >= 1")[
            ["on_street_name", "injured_cyclists"]
        ]
        .sort_values(by=["injured_cyclists"], ascending=False)
        .dropna(how="any")[:10]
    )

elif select == "Motorists":
    st.write(
        original_data.query("injured_motorists >= 1")[
            ["on_street_name", "injured_motorists"]
        ]
        .sort_values(by=["injured_motorists"], ascending=False)
        .dropna(how="any")[:10]
    )

st.subheader("Heatmap of Collisions")
st.pydeck_chart(
    pdk.Deck(
        map_style="mapbox://styles/mapbox/light-v9",
        initial_view_state={
            "latitude": midpoint[0],
            "longitude": midpoint[1],
            "zoom": 11,
            "pitch": 50,
        },
        layers=[
            pdk.Layer(
                "HeatmapLayer",
                data=data[["date/time", "latitude", "longitude"]],
                get_position=["longitude", "latitude"],
                radius=100,
                intensity=1,
                elevation_scale=4,
                elevation_range=[0, 1000],
            ),
        ],
    )
)

st.header("Breakdown by Borough")
borough_data = data["borough"].value_counts().reset_index()
borough_data.columns = ["Borough", "Collisions"]
fig = px.bar(
    borough_data,
    x="Borough",
    y="Collisions",
    color="Borough",
    title="Number of Collisions by Borough",
)
st.plotly_chart(fig)


st.header("Time Series Analysis of Collisions")
time_data = data.resample("M", on="date/time").size().reset_index()
time_data.columns = ["Month", "Collisions"]
fig = px.line(time_data, x="Month", y="Collisions", title="Collisions Over Time")
st.plotly_chart(fig)


st.header("Analysis of Collisions Contributing Factor")
contributing_factor = [
    "contributing_factor_vehicle_1",
    "contributing_factor_vehicle_2",
    "contributing_factor_vehicle_3",
    "contributing_factor_vehicle_4",
    "contributing_factor_vehicle_5",
]
factor_data = data[contributing_factor].stack().value_counts().reset_index()
factor_data.columns = ["Contributing Factor", "Collisions"]
factor_data = factor_data[factor_data["Contributing Factor"] != "Unspecified"]
fig = px.line(
    factor_data.head(10),
    x="Contributing Factor",
    y="Collisions",
    title="Top 10 Contributing Factors in Collisions",
    markers=True,
)
st.plotly_chart(fig)


st.header("Analysis of Collisions by Vehicle Type")
vehicle_types = [
    "vehicle_type_1",
    "vehicle_type_2",
    "vehicle_type_3",
    "vehicle_type_4",
    "vehicle_type_5",
]
vehicle_data = data[vehicle_types].stack().value_counts().reset_index()
vehicle_data.columns = ["Vehicle Type", "Collisions"]
vehicle_data = vehicle_data[vehicle_data["Vehicle Type"] != "Unspecified"]
fig = px.bar(
    vehicle_data.head(10),
    x="Vehicle Type",
    y="Collisions",
    color="Collisions",
    title="Top 10 Vehicle Types Involved in Collisions",
)
st.plotly_chart(fig)


if st.checkbox("Show Raw Data", False):
    st.subheader("Raw Data")
    st.write(data)
