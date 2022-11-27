import 'package:flutter/material.dart';
import 'package:my_perpus/helper/color_palette.dart';
import 'package:my_perpus/helper/constants.dart';
import 'package:my_perpus/model/peminjaman_model.dart';
import 'package:my_perpus/ui/widget/status_container.dart';

class StatusPeminjaman extends StatelessWidget {
  const StatusPeminjaman({Key? key, required this.peminjamanModel})
      : super(key: key);
  final PeminjamanModel peminjamanModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: kRoundedContainer.copyWith(
          border: Border.all(color: Colors.white, width: 2)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  parseDate(peminjamanModel.tanggalPeminjaman.toString()),
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              StatusContainer(status: peminjamanModel.status)
            ],
          ),
          SizedBox(height: 10),
          Text(
            "ID Peminjaman: " + peminjamanModel.id!,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 5),
          Text(
            peminjamanModel.userModel.email,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          if (peminjamanModel.status ==2)
            Text(
              getDurationDifference(DateTime.now(),
                  peminjamanModel.tanggalPengembalian!),
              style: TextStyle(
                  fontSize: 16,
                  color: getDurationDifferenceInt(
                              peminjamanModel.tanggalPeminjaman!,
                              peminjamanModel.tanggalPengembalian!) >
                          2
                      ? Colors.amber
                      : Colors.red),
            ),
        ],
      ),
    );
  }
}
