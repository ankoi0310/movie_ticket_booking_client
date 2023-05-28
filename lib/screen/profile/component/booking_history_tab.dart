import 'package:data_table_2/data_table_2.dart';
import 'package:movie_ticket_booking_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/invoice.dart';
import 'package:movie_ticket_booking_flutter_nlu/source/invoice_data_source.dart';

class BookingHistoryTab extends StatelessWidget {
  const BookingHistoryTab({
    Key? key,
    required this.invoices,
  }) : super(key: key);

  final List<Invoice> invoices;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              top: getProportionateScreenHeight(10),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenHeight(25),
                    vertical: getProportionateScreenHeight(20),
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.zero,
                    shape: BoxShape.rectangle,
                  ),
                  clipBehavior: Clip.none,
                  child: PaginatedDataTable2(
                    empty: const Text('Không có dữ liệu'),
                    rowsPerPage: 5,
                    source: InvoiceDataSource(context: context, invoices: invoices),
                    autoRowsToHeight: true,
                    border: const TableBorder(
                      borderRadius: BorderRadius.zero,
                      top: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                      bottom: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                      left: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                      right: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                      horizontalInside: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                      verticalInside: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    columns: const [
                      DataColumn2(
                        label: Center(child: Text('Mã hóa đơn')),
                        size: ColumnSize.L,
                      ),
                      DataColumn2(
                        label: Center(child: Text('Ngày đặt vé')),
                        size: ColumnSize.L,
                      ),
                      DataColumn2(
                        label: Center(child: Text('Trạng thái')),
                        size: ColumnSize.L,
                      ),
                      DataColumn2(
                        label: Text(''),
                        size: ColumnSize.S,
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: getProportionateScreenHeight(-25),
                  left: getProportionateScreenWidth(10),
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Padding(
                      padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                      child: const Text(
                        'Lịch sử đặt vé',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
