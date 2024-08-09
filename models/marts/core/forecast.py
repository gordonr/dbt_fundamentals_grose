#Import required libraries
import pandas as pd
import unidecode

import numpy as np
from prophet import Prophet

#Import dbt library
#import dbt

def model(dbt, session):

    x = unidecode('kožušček')

    dbt.config(materialized="table", packages=['Prophet', 'pandas', 'numpy', 'unidecode'])
    # dbt.config(materialized="table")
    # DataFrame representing the database table.
    #upstream_model = dbt.ref("fct_orders")

    # Create a dataframe from the upstream model
    #df = pd.DataFrame(upstream_model.fetch(session))
    df = dbt.ref("fct_orders").toPandas()

    # Create a new column for the month of the order_date
    #df['order_month'] = df['ORDER_DATE'].dt.month
    #df['order_month'] = pd.to_datetime(df['ORDER_DATE'], format='%Y-%m-%d').dt.month
    #df['order_month'] = pd.to_datetime(df['ORDER_DATE'], errors='coerce', format='%Y-%m-%d').dt.month
    df['order_month'] = pd.to_datetime(df['ORDER_DATE'], errors='ignore', infer_datetime_format=True, yearfirst=True).dt.month
    
    df['order_month'] = pd.to_datetime(df['ORDER_DATE'])
    df['order_month'] = df['order_month'].dt.strftime("%Y-%m")

    #df['order_month'] = pd.to_datetime(df['ORDER_DATE'], errors='coerce', utc=True).dt.strftime('%Y-%m-%d').month
    
    #df['order_month'] = pd.to_datetime(df['ORDER_DATE'], errors='coerce', utc=True).dt.month
    
    #df['order_month'] = pd.DatetimeIndex(df['ORDER_DATE']).month
    
    # Create a dataframe with the sum of the amount for each month
    df_sum = df.groupby('order_month')['PAYMENT_AMOUNT'].sum().reset_index()

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