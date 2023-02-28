#Import required libraries
import pandas as pd

import numpy as np
from prophet import Prophet

#Import dbt library
import dbt

def model(dbt, session):

    dbt.config(materialized="table", packages=['Prophet', 'pandas', 'numpy'])
    # dbt.config(materialized="table")
    # DataFrame representing the database table.
    upstream_model = dbt.ref("fct_orders")

    # Create a dataframe from the upstream model
    df = pd.DataFrame(upstream_model.fetch(session))

    # Create a new column for the month of the order_date
    df['order_month'] = df['ORDER_DATE'].dt.month

    # Create a dataframe with the sum of the amount for each month
    df_sum = df.groupby('order_month')['AMOUNT'].sum().reset_index()

    # Rename columns
    df_sum.columns = ['ds', 'y']

    # Create and fit a Prophet model
    m = Prophet()
    m.fit(df_sum)

    # Create a dataframe to hold the forecast
    future = m.make_future_dataframe(periods=6, freq='M')

    # Make a forecast
    forecast = m.predict(future)

    # Create a dataframe with the forecast
    forecast_df = forecast[['ds', 'yhat']]

    return forecast_df;