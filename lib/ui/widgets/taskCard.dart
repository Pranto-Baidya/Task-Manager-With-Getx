import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:untitled3/data/models/network_caller.dart';
import 'package:untitled3/data/models/taskModel.dart';
import 'package:untitled3/data/screen_Controllers/taskCard_controller.dart';
import 'package:untitled3/data/services/network-response.dart';
import 'package:untitled3/data/utils/all_urls.dart';
import 'package:untitled3/ui/utils/app_Colors.dart';
import 'package:untitled3/ui/utils/spinkit.dart';
import 'package:untitled3/ui/utils/toastMessage.dart';
import 'package:intl/intl.dart';

class taskCard extends StatefulWidget {
  const taskCard({
    super.key,
    required this.model ,
    required this.onRefreshList,

  });

  final taskModel model;
  final VoidCallback onRefreshList;

  @override
  State<taskCard> createState() => _taskCardState();
}

class _taskCardState extends State<taskCard> {

  String selectedStatus = '';
  final taskCardController controller = Get.find<taskCardController>();

  @override
  void initState() {
    super.initState();
    selectedStatus = widget.model.status ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(colors: [Colors.white, Colors.white]),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 7),
              blurRadius: 7,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 5),
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SelectableText(
                  widget.model.title ?? '',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SelectableText(
                  widget.model.description ?? '',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 5),
                Text(
                  'Created date : ${widget.model.getFormattedDate()}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 5),
                Divider(color: Colors.grey.shade400),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildChip(),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        IconButton(
                          onPressed: _onTapEdit,
                          icon: Icon(Icons.task_alt, color: Color(0xFF003366)),
                        ),
                        GetBuilder<taskCardController>(
                          builder: (controller) {
                            return controller.isDeleteInProgress(
                                widget.model.sId!)
                                ? Center(child: spinKit.taskLoader())
                                : IconButton(
                              onPressed: _onTapDelete,
                              icon: Icon(Icons.delete_outline,
                                  color: Color(0xFF003366), size: 26),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onTapDelete() async {
    final bool result = await controller.onTapDelete(widget.model.sId!);

    if (result) {
      widget.onRefreshList();
      SuccessToast('Successfully deleted');
    }
  }

  Widget _buildChip() {
    Color getColor() {
      switch (widget.model.status) {
        case 'New':
          return Colors.blue;
        case 'Completed':
          return Colors.green;
        case 'In progress':
          return Colors.orange;
        case 'Cancelled':
          return Colors.red;
        default:
          return Colors.grey;
      }
    }

    return Chip(
      label: Text(
        widget.model.status ?? '',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      side: BorderSide.none,
      backgroundColor: getColor(),
    );
  }

  void _onTapEdit(){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            backgroundColor: Color(0xFFFFFEF1),
            title: Text('Mark task as',style: TextStyle(color: Color(0xFF003366),fontWeight: FontWeight.w600),),
            content: Column(

              mainAxisSize: MainAxisSize.min,
              children: ['New','Completed','In progress','Cancelled'].map((e){
                return ListTile(
                    leading: selectedStatus==e? Icon(Icons.radio_button_checked,color: Color(0xFF003366),)
                        :Icon(Icons.radio_button_checked,color: Colors.black45),
                    onTap: (){
                      _changeStatus(e);
                      Navigator.pop(context);
                    },
                    title: Text(e,style: TextStyle(color: Color(0xFF003366),fontWeight: FontWeight.w500),),
                    selected: selectedStatus == e,
                    trailing: selectedStatus==e ? Icon(Icons.check,color: Color(0xFF003366),):null
                );
              }).toList(),
            ),
            actions: [
              TextButton(
                  onPressed: (){
                    Get.back();
                  },
                  child: Text('Cancel',style: TextStyle(color: Color(0xFF003366),fontWeight: FontWeight.w500),)
              ),

            ],
          );
        }
    );
  }

  Future<void> _changeStatus(String newStatus) async {
    final bool result = await controller.changeStatus(
      widget.model.sId!,
      newStatus,
      widget.onRefreshList,
    );

    if (result) {
      widget.onRefreshList();
    }
  }
}
