# Motor Vehicle Collisions in New York City - Streamlit Dashboard

This Streamlit dashboard is designed to analyze motor vehicle collisions in New York City. It utilizes a dataset containing details of crashes to provide insights through interactive visualizations and filters.

## Key Features

- **Data Loading:** The dataset is loaded into the application with an option to specify the number of rows. It is then preprocessed to ensure data quality and usability.

- **Sidebar Filters:**

  - **Date Range:** Allows filtering collisions based on a specific date range.
  - **Time of Day:** Enables filtering based on the time of day.
  - **Borough:** Provides a dropdown to filter collisions by borough.
  - **Collision Severity:** Allows filtering based on the minimum number of persons injured.
  - **Vehicle Type:** Offers a multiselect option to filter collisions based on vehicle types involved.

- **Main Visualizations:**

  - **Injury Map:** Displays a map showing locations with a specified number of injured persons.
  - **Collisions by Hour:** Shows the number of collisions occurring during a specific hour of the day.
  - **Hexagon Layer Map:** A hexagon layer map provides a 3D visualization of collision density during the selected hour.
  - **Minute Breakdown:** A bar chart breaks down collisions by minute within the selected hour.
  - **Dangerous Streets:** Lists the top 10 dangerous streets by the affected type of people (Pedestrians, Cyclists, Motorists).
  - **Heatmap:** A heatmap visualizes the density of collisions across the city.
  - **Borough Breakdown:** A bar chart showing the number of collisions by borough.
  - **Time Series Analysis:** A line chart depicting the trend of collisions over time.
  - **Contributing Factors:** Analyzes the top contributing factors to collisions.
  - **Vehicle Types Involved:** Shows the top vehicle types involved in collisions.

- **Raw Data Toggle:** A checkbox to display the raw data used in the visualizations.

## Usage

To run the app, navigate to the app's directory and use the following command:

```bash
streamlit run app.py
```

## Based on an Online Course

This dashboard app is inspired by the course "Build a Data Science Web App with Streamlit and Python" taught by Snehan Kekre on the Rhyme platform, which is part of Coursera. The course focuses on two main learning objectives:

- Building interactive web applications with Streamlit and Python.
- Using pandas for data manipulation in data science workflows.

The course is structured into three parts: an overview, a hands-on project to build a data science web app with Streamlit and Python, and a graded quiz. The project is divided into tasks that cover various aspects of creating a web app, from turning simple Python scripts into web apps to loading and visualizing data, filtering data, creating interactive tables and maps, and more.

## Enhancements to the App

While the initial app was based on the course, I have significantly enhanced its functionality and features:

- Added more sophisticated filters in the sidebar, including filtering by date range, time of day, borough, collision severity, and vehicle type.
- Included additional visualizations such as a heatmap of collisions, a breakdown of collisions by borough, a time series analysis of collisions over time, an analysis of collisions by contributing factors, and an analysis of collisions by vehicle type.
- Improved the user interface and interactivity of the app to provide a more engaging and informative experience for users.

These enhancements aim to provide a deeper analysis of motor vehicle collisions in New York City and showcase my skills in data manipulation, visualization, and building interactive web applications with Streamlit and Python.
