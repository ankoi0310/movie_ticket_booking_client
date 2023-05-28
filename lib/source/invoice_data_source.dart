import 'package:data_table_2/data_table_2.dart';
import 'package:movie_ticket_booking_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/invoice.dart';
import 'package:movie_ticket_booking_flutter_nlu/utilities/StringUtil.dart';

class InvoiceDataSource extends DataTableSource {
  InvoiceDataSource({
    required this.context,
    required this.invoices,
  });

  final BuildContext context;
  final List<Invoice> invoices;

  @override
  DataRow2 getRow(int index) {
    assert(index >= 0);
    final Invoice invoice = invoices[index];
    return DataRow2.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Center(child: Text(invoice.code.toString()))),
        DataCell(Center(child: Text(DateFormat('dd-MM-yyyy HH:mm:ss').format(invoice.paymentDate)))),
        DataCell(Center(child: Text(StringUtil.changePaymentStatus(invoice.paymentStatus)))),
        DataCell(
          Center(
            child: IconButton(
              icon: const Icon(Icons.remove_red_eye),
              tooltip: 'Xem chi tiết',
              onPressed: () {
                if (Responsive.isDesktop(context)) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Thông tin hoá đơn'),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      content: Container(
                        width: SizeConfig.screenWidth * 0.5,
                        padding: const EdgeInsets.only(top: 8, bottom: 18),
                        child: Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          direction: Axis.horizontal,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            SizedBox(
                              width: SizeConfig.screenWidth * 0.5 * 0.45,
                              child: Row(
                                children: [
                                  const Text(
                                    'Mã hoá đơn: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(invoice.code),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: SizeConfig.screenWidth * 0.5 * 0.45,
                              child: Row(
                                children: [
                                  const Text(
                                    'Họ tên khách hàng: ',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(invoice.name),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: SizeConfig.screenWidth * 0.5 * 0.45,
                              child: Row(
                                children: [
                                  const Text(
                                    'Thành tiền: ',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(NumberFormat.currency(locale: 'vi').format(invoice.totalPrice)),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: SizeConfig.screenWidth * 0.5 * 0.45,
                              child: Row(
                                children: [
                                  const Text(
                                    'Trạng thái: ',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(StringUtil.changePaymentStatus(invoice.paymentStatus).toUpperCase()),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: SizeConfig.screenWidth * 0.5 * 0.45,
                              child: Row(
                                children: [
                                  const Text(
                                    'Email: ',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(invoice.email),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: SizeConfig.screenWidth * 0.5 * 0.45,
                              child: Row(
                                children: [
                                  const Text(
                                    'Phương thức thanh toán: ',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(invoice.paymentMethod.value),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: SizeConfig.screenWidth * 0.5 * 0.45,
                              child: Row(
                                children: [
                                  const Text(
                                    'Ngày thanh toán: ',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(DateFormat('dd/MM/yyyy HH:mm:ss').format(invoice.paymentDate)),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: SizeConfig.screenWidth * 0.5 * 0.45,
                              child: Row(
                                children: [
                                  const Text(
                                    'Liên kết tài khoản: ',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(invoice.appUser != null ? 'Có' : 'Không'),
                                ],
                              ),
                            ),
                            Container(
                              width: SizeConfig.screenWidth * 0.5,
                              margin: const EdgeInsets.only(top: 10),
                              child: const Text(
                                'Chi tiết vé',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: SizeConfig.screenWidth * 0.5 * 0.45,
                              child: Row(
                                children: [
                                  const Text(
                                    'Phim: ',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(invoice.showTime.movie!.name),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: SizeConfig.screenWidth * 0.5 * 0.45,
                              child: Row(
                                children: [
                                  const Text(
                                    'Thể loại chiếu: ',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(StringUtil.changeMovieFormat(invoice.showTime.movieFormat)),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: SizeConfig.screenWidth * 0.5 * 0.45,
                              child: Row(
                                children: [
                                  const Text(
                                    'Chi nhánh: ',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(invoice.showTime.room!.branch.name),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: SizeConfig.screenWidth * 0.5 * 0.45,
                              child: Row(
                                children: [
                                  const Text(
                                    'Phòng: ',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(invoice.showTime.room!.name),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: SizeConfig.screenWidth * 0.5 * 0.45,
                              child: Row(
                                children: [
                                  const Text(
                                    'Loại: ',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(invoice.showTime.room!.type.value),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: SizeConfig.screenWidth * 0.5 * 0.45,
                              child: Row(
                                children: [
                                  const Text(
                                    'Thời gian chiếu: ',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(DateFormat('dd/MM/yyyy HH:mm:ss').format(invoice.showTime.startTime!)),
                                ],
                              ),
                            ),
                            Container(
                              width: SizeConfig.screenWidth * 0.5,
                              margin: const EdgeInsets.only(top: 10),
                              child: const Text(
                                'Danh sách vé đã mua',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Container(
                              color: Colors.white,
                              width: SizeConfig.screenWidth * 0.5,
                              child: Table(
                                border: TableBorder.all(color: Colors.black),
                                children: [
                                  TableRow(children: [
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      child: const Text(
                                        'Ghế ngồi',
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      child: const Text(
                                        'Giá vé',
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      child: const Text(
                                        'Loại ghế',
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                      ),
                                    ),
                                  ]),
                                  ...invoice.tickets.map((ticket) {
                                    return TableRow(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(5),
                                          child: Text(
                                            invoice.tickets[index].seat.code,
                                            style: const TextStyle(fontSize: 16),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(5),
                                          child: Text(
                                            NumberFormat.currency(locale: 'vi').format(invoice.showTime.price),
                                            style: const TextStyle(fontSize: 16),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(5),
                                          child: Text(
                                            StringUtil.changeSeatType(invoice.tickets[index].seat.seatType),
                                            style: const TextStyle(fontSize: 16),
                                          ),
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                ],
                              ),
                            ),
                            Container(
                              width: SizeConfig.screenWidth * 0.5,
                              margin: const EdgeInsets.only(top: 10),
                              child: const Text(
                                'Danh sách combo đã mua',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Container(
                              color: Colors.white,
                              width: SizeConfig.screenWidth * 0.5,
                              child: Table(
                                border: TableBorder.all(color: Colors.black),
                                children: [
                                  TableRow(children: [
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      child: const Text(
                                        'Combo',
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      child: const Text(
                                        'Số lượng',
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      child: const Text(
                                        'Tổng giá',
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                      ),
                                    ),
                                  ]),
                                  ...invoice.invoiceCombos.map((invoiceCombo) {
                                    return TableRow(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(5),
                                          child: Text(
                                            invoiceCombo.combo!.name,
                                            style: const TextStyle(fontSize: 16),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(5),
                                          child: Text(
                                            invoiceCombo.quantity.toString(),
                                            style: const TextStyle(fontSize: 16),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(5),
                                          child: Text(
                                            NumberFormat.currency(locale: 'vi').format(invoiceCombo.quantity * invoiceCombo.combo!.price),
                                            style: const TextStyle(fontSize: 16),
                                          ),
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  int get rowCount => invoices.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
