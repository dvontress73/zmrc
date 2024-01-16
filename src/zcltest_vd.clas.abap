CLASS zcltest_vd DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.

TYPES tt_bp_struct_tst TYPE STANDARD TABLE OF ZZVD_TEST WITH EMPTY KEY.
    METHODS get_bp_details RETURNING VALUE(rt_table) TYPE tt_bp_struct_tst.
    METHODS get_bp_codesnippet RETURNING VALUE(rt_table) TYPE tt_bp_struct_tst.
ENDCLASS.



CLASS ZCLTEST_VD IMPLEMENTATION.


METHOD get_bp_codesnippet.
    TRY.
        "create http destination by url; API endpoint for API sandbox
        DATA(lo_http_destination) =
             cl_http_destination_provider=>create_by_url( 'https://sandbox.api.sap.com/s4hanacloud/sap/opu/odata/sap/API_BANKDETAIL_SRV/A_BankDetail?$inlinecount=allpages&$filter=BANKCOUNTRY EQ ''DE''&$top=50' ).
        "alternatively create HTTP destination via destination service
        "cl_http_destination_provider=>create_by_cloud_destination( i_name = '<...>'
        "                            i_service_instance_name = '<...>' )
        "SAP Help: https://help.sap.com/viewer/65de2977205c403bbc107264b8eccf4b/Cloud/en-US/f871712b816943b0ab5e04b60799e518.html

        "create HTTP client by destination
        DATA(lo_web_http_client) = cl_web_http_client_manager=>create_by_http_destination( lo_http_destination ) .

        "adding headers with API Key for API Sandbox
        DATA(lo_web_http_request) = lo_web_http_client->get_http_request( ).
        lo_web_http_request->set_header_fields( VALUE #(
        (  name = 'APIKey' value = 'mjqSVH08Y4FQNGnW1il2UdudNRVYAlmB' )
        (  name = 'DataServiceVersion' value = '2.0' )
        (  name = 'Accept' value = 'application/json' )
         ) ).

        "set request method and execute request
        DATA(lo_web_http_response) = lo_web_http_client->execute( if_web_http_client=>get ).
        DATA(lv_response) = lo_web_http_response->get_text( ).

      CATCH cx_http_dest_provider_error cx_web_http_client_error cx_web_message_error.
        "error handling
    ENDTRY.

    "uncomment the following line for console output; prerequisite: code snippet is implementation of if_oo_adt_classrun~main
    "out->write( |response:  { lv_response }| ).

  ENDMETHOD.


  METHOD get_bp_details.

    DATA:
      lt_business_data TYPE TABLE OF ZZVD_TEST,
      lo_http_client   TYPE REF TO if_web_http_client,
      lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
      lo_request       TYPE REF TO /iwbep/if_cp_request_read_list,
      lo_response      TYPE REF TO /iwbep/if_cp_response_read_lst.

    DATA:
      lo_filter_factory        TYPE REF TO /iwbep/if_cp_filter_factory,
      lo_filter_node_1         TYPE REF TO /iwbep/if_cp_filter_node,
* lo_filter_node_2    TYPE REF TO /iwbep/if_cp_filter_node,
      lo_filter_node_root      TYPE REF TO /iwbep/if_cp_filter_node,
      lt_range_businesspartner TYPE RANGE OF ZZVD_TEST-businesspartner.
* lt_range_CUSTOMER TYPE RANGE OF <element_name>.



    TRY.
        " Create http client
*DATA(lo_destination) = cl_http_destination_provider=>create_by_comm_arrangement(
*                                             comm_scenario  = '<Comm Scenario>'
*                                             comm_system_id = '<Comm System Id>'
*                                             service_id     = '<Service Id>' ).
*lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).

        DATA: lv_url TYPE string VALUE 'https://sandbox.api.sap.com/'.
        lo_http_client = cl_web_http_client_manager=>create_by_http_destination(
                        i_destination = cl_http_destination_provider=>create_by_url( lv_url ) ).

        lo_http_client->get_http_request( )->set_header_fields( VALUE #(
             (  name = 'APIKey' value = 'mjqSVH08Y4FQNGnW1il2UdudNRVYAlmB') ) ).



        lo_client_proxy = cl_web_odata_client_factory=>create_v2_remote_proxy(
          EXPORTING
            iv_service_definition_name = 'Z_BP_A2X_API_DS'
            io_http_client             = lo_http_client
            iv_relative_service_root   = 's4hanacloud/sap/opu/odata/sap/API_BUSINESS_PARTNER' ).

        ASSERT lo_http_client IS BOUND.



        " Navigate to the resource and create a request for the read operation
        lo_request = lo_client_proxy->create_resource_for_entity_set( 'A_BUSINESSPARTNER' )->create_request_for_read( ).

        " Create the filter tree
        lo_filter_factory = lo_request->create_filter_factory( ).
        lt_range_businesspartner = VALUE #( ( sign = 'I' option = 'EQ' low = '200' high = '250' ) ).
*
        lo_filter_node_1  = lo_filter_factory->create_by_range( iv_property_path     = 'BUSINESSPARTNER'
                                                                it_range             = lt_range_businesspartner ).
*lo_filter_node_2  = lo_filter_factory->create_by_range( iv_property_path     = 'CUSTOMER'
*                                                        it_range             = lt_range_CUSTOMER ).


        lo_filter_node_root = lo_filter_node_1.
*lo_filter_node_root = lo_filter_node_1->and( lo_filter_node_2 ).
        lo_request->set_filter( lo_filter_node_root ).

        lo_request->set_top( 5 )->set_skip( 0 ).

        " Execute the request and retrieve the business data
        lo_response = lo_request->execute( ).
        lo_response->get_business_data( IMPORTING et_business_data = rt_table ). "lt_business_data ).

      CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
        " Handle remote Exception
        " It contains details about the problems of your http(s) connection

      CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
        RAISE SHORTDUMP  lx_gateway.

      CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
        " Handle Exception
        RAISE SHORTDUMP lx_web_http_client_error.


    ENDTRY.

  ENDMETHOD.


  METHOD if_oo_adt_classrun~main.
  out->write( get_bp_details(  ) ).

  ENDMETHOD.
ENDCLASS.
