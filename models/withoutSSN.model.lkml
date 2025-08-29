connection: "sample_bigquery_connection"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

explore: order_items_wo_ssn {
  label: "Without SSN"
  from: order_items

  join: order_facts {
    type: left_outer
    view_label: "Orders"
    relationship: many_to_one
    sql_on: ${order_facts.order_id} = ${order_items_wo_ssn.order_id} ;;
  }

  join: inventory_items {
    view_label: "Inventory Items"
    #Left Join only brings in items that have been sold as order_item
    type: full_outer
    relationship: one_to_one
    sql_on: ${inventory_items.id} = ${order_items_wo_ssn.inventory_item_id} ;;
  }

  join: users2 {
    view_label: "Users"
    type: left_outer
    relationship: many_to_one
    sql_on: ${order_items_wo_ssn.user_id} = ${users2.id} ;;
  }
}
