library mawa_package;

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dependencies.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io' as io;
import 'package:permission_handler/permission_handler.dart' as per;
import 'package:http_parser/http_parser.dart' as parser;
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:core';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:dropdown_search/dropdown_search.dart';
// import 'package:mawa_package/services/notification.dart' as nt;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:email_validator/email_validator.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:file_picker/file_picker.dart';


part 'package:mawa_package/mawa.dart';

part 'package:mawa_package/keys/claim_types.dart';
part 'package:mawa_package/keys/comment_types.dart';
part 'package:mawa_package/keys/field_option_types.dart';
part 'package:mawa_package/keys/id_types.dart';
part 'package:mawa_package/keys/json_payloads.dart';
part 'package:mawa_package/keys/json_responses.dart';
part 'package:mawa_package/keys/membership_types.dart';
part 'package:mawa_package/keys/object_types.dart';
part 'package:mawa_package/keys/partner_attributes.dart';
part 'package:mawa_package/keys/partner_roles.dart';
part 'package:mawa_package/keys/partner_types.dart';
part 'package:mawa_package/keys/path_names.dart';
part 'package:mawa_package/keys/product_types.dart';
part 'package:mawa_package/keys/query_parameters.dart';
part 'package:mawa_package/keys/resources.dart';
part 'package:mawa_package/keys/shared_preferences.dart';
part 'package:mawa_package/keys/status_reasons.dart';
part 'package:mawa_package/keys/statuses.dart';
part 'package:mawa_package/keys/tender_types.dart';

part 'package:mawa_package/screens/alerts.dart';
part 'package:mawa_package/screens/authenticate_view.dart';
part 'package:mawa_package/screens/change_password.dart';
part 'package:mawa_package/screens/forgot_password.dart';
part 'package:mawa_package/screens/init_route.dart';
part 'package:mawa_package/screens/no_internet_connection.dart';
part 'package:mawa_package/screens/otp.dart';
part 'package:mawa_package/screens/outdated_version.dart';
part 'package:mawa_package/screens/overlay_widgets.dart';
part 'package:mawa_package/screens/page_not_found.dart';
part 'package:mawa_package/screens/snapshort_static_widgets.dart';
part 'package:mawa_package/screens/unauthorized.dart';
part 'package:mawa_package/screens/attach_base64_file.dart';
part 'package:mawa_package/screens/user_overview.dart';

part 'package:mawa_package/services/attachments.dart';
part 'package:mawa_package/services/attachment.dart';
part 'package:mawa_package/services/authenticate.dart';
part 'package:mawa_package/services/bank.dart';
part 'package:mawa_package/services/booking.dart';
part 'package:mawa_package/services/calculate_pricing.dart';
part 'package:mawa_package/services/cashup.dart';
part 'package:mawa_package/services/claim.dart';
part 'package:mawa_package/services/client_policy.dart';
part 'package:mawa_package/services/comment.dart';
part 'package:mawa_package/services/constants.dart';
part 'package:mawa_package/services/customers.dart';
part 'package:mawa_package/services/deposit.dart';
part 'package:mawa_package/services/device_info.dart';
part 'package:mawa_package/services/employees.dart';
part 'package:mawa_package/services/field_options.dart';
part 'package:mawa_package/services/field.dart';
part 'package:mawa_package/services/globals.dart';
part 'package:mawa_package/services/group_society.dart';
part 'package:mawa_package/services/internet_connect.dart';
part 'package:mawa_package/services/invoice.dart';
part 'package:mawa_package/services/items.dart';
part 'package:mawa_package/services/laybys.dart';
part 'package:mawa_package/services/leaves.dart';
part 'package:mawa_package/services/location.dart';
part 'package:mawa_package/services/membership.dart';
part 'package:mawa_package/services/network_requests.dart';
part 'package:mawa_package/services/notification.dart';
part 'package:mawa_package/services/notifications.dart';
part 'package:mawa_package/services/organisation.dart';
part 'package:mawa_package/services/otp.dart';
part 'package:mawa_package/services/partners.dart';
part 'package:mawa_package/services/persons.dart';
part 'package:mawa_package/services/premium.dart';
part 'package:mawa_package/services/products.dart';
part 'package:mawa_package/services/prospect.dart';
part 'package:mawa_package/services/purchase_order.dart';
part 'package:mawa_package/services/quotation.dart';
part 'package:mawa_package/services/receipts.dart';
part 'package:mawa_package/services/role.dart';
part 'package:mawa_package/services/sale_order.dart';
part 'package:mawa_package/services/service_request.dart';
part 'package:mawa_package/services/shared_storage.dart';
part 'package:mawa_package/services/strings.dart';
part 'package:mawa_package/services/supplier.dart';
part 'package:mawa_package/services/task.dart';
part 'package:mawa_package/services/tickets.dart';
part 'package:mawa_package/services/ticket_logs.dart';
part 'package:mawa_package/services/timer.dart';
part 'package:mawa_package/services/token.dart';
part 'package:mawa_package/services/tools.dart';
part 'package:mawa_package/services/transaction_notes.dart';
part 'package:mawa_package/services/user.dart';
part 'package:mawa_package/services/versions.dart';
part 'package:mawa_package/services/workcenters.dart';
part 'package:mawa_package/services/vouchers.dart';
part 'package:mawa_package/services/pricing_engine.dart';
