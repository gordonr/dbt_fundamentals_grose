def model(dbt, session):

    # get upstream data
    orders = dbt.ref("fct_orders")

    # describe the data
    described = fct_orders.describe()

    return described
