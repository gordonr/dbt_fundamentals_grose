def model(dbt, session):

    dbt.config(materialized="table")

    # get upstream data
    fct_orders = dbt.ref("fct_orders")

    # describe the data
    described = fct_orders.describe()

    return described
