import 'package:capstone/schedule/const/colors.dart';
import 'package:flutter/material.dart';


import 'package:flutter/material.dart';
import 'package:capstone/schedule/component/custom_text_field.dart';
import 'package:capstone/schedule/const/colors.dart';

import 'package:drift/drift.dart' hide Column;
//material.dart 패키지의 column 클래스와 중복되니 드리프트에서는 숨기기
import 'package:get_it/get_it.dart';
import 'package:capstone/schedule/database/drift_database.dart';


class dayPlanSheet extends StatefulWidget {
  final DateTime selectedDate;

  const dayPlanSheet({
    required this.selectedDate,
    Key? key
  }) : super(key: key);

  @override
  State<dayPlanSheet> createState() => _dayPlanSheetState();
}

class _dayPlanSheetState extends State<dayPlanSheet> {
  final GlobalKey<FormState> _formkey = GlobalKey();

  int? startTime;
  int? startTime2;
  int? endTime;
  int? endTime2;
  String? title;
  String? place;
  String? memo;


  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Form( //텍스트 필드를 한 번에 관리 가능.
        key: _formkey, // form을 조작할 키 값.
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: SingleChildScrollView(
              child: SizedBox(
                child: Column(
                  // ➋ 시간 관련 텍스트 필드와 내용관련 텍스트 필드 세로로 배치
                  children: [
                    Container(
                      height: 45,
                      width: 300,
                      child: TextField(
                        onChanged: (String value) {
                          title = value; // 입력된 제목을 변수에 저장
                        },
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Please enter some text';
                        //   }
                        //   return null;
                        // },

                        decoration: InputDecoration(
                          labelText: '일정명',
                          labelStyle: TextStyle(fontSize: 14),
                          floatingLabelBehavior: FloatingLabelBehavior.never, // Disable floating label
                          filled: true, // 배경색 적용
                          fillColor: Colors.grey[200], // 배경색 설정
                          border: OutlineInputBorder( // 텍스트 필드의 테두리 스타일 설정
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none, // 테두리 없음
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 10,),

                    Container(
                      height: 45,
                      width: 300,
                      child: TextField(
                        onChanged: (String value) {
                          place = value; // 입력된 제목을 변수에 저장
                        },
                        decoration: InputDecoration(
                          labelText: '장소',
                          labelStyle: TextStyle(fontSize: 14),
                          floatingLabelBehavior: FloatingLabelBehavior.never, // Disable floating label
                          suffixIcon: const Icon(Icons.location_on, color: Colors.black), // 돋보기 아이콘 추가 및 색상 설정
                          filled: true, // 배경색 적용
                          fillColor: Colors.grey[200], // 배경색 설정
                          border: OutlineInputBorder( // 텍스트 필드의 테두리 스타일 설정
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none, // 테두리 없음
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height:10,),

                    // Container(
                    //   width: 300,
                    //   child: Row(
                    //     // ➊ 시작 시간 종료 시간 가로로 배치
                    //     children: [
                    //       Expanded(
                    //         child: CustomTextField(
                    //           // 시작시간 입력 필드
                    //           label: '시작 시간',
                    //           isTime: true,
                    //           onSaved: (String? val){
                    //             //저장이 되면 startTime 변수에 텍스트 필드값 저장.
                    //             startTime = int.parse(val!);
                    //           },
                    //           validator: timeValidator,
                    //         ),
                    //       ),
                    //       const SizedBox(width: 16.0),
                    //       Expanded(
                    //         child: CustomTextField(
                    //           // 종료시간 입력 필드
                    //           label: '종료 시간',
                    //           isTime: true,
                    //           onSaved: (String? val){
                    //             //저장이 되면 startTime 변수에 텍스트 필드값 저장.
                    //             endTime = int.parse(val!);
                    //           },
                    //           validator: timeValidator,
                    //
                    //
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // SizedBox(height: 11.0),

                    Row(
                      children: [
                        Container(
                          height: 45,
                          width: 137,
                          child: TextField(
                            onChanged: (String? val) {
                              startTime2 = int.parse(val!);
                            },
                            decoration: InputDecoration(
                              labelText: '시작 시간',
                              labelStyle: TextStyle(fontSize: 14),
                              floatingLabelBehavior: FloatingLabelBehavior.never, // Disable floating label
                              filled: true, // 배경색 적용
                              fillColor: Colors.grey[200], // 배경색 설정
                              border: OutlineInputBorder( // 텍스트 필드의 테두리 스타일 설정
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none, // 테두리 없음
                              ),
                            ),
                          ),
                        ),

                        SizedBox(width: 15,),

                        Container(
                          height: 45,
                          width: 137,
                          child: TextField(
                            onChanged: (String? val) {
                              endTime2 = int.parse(val!);
                            },
                            decoration: InputDecoration(
                              labelText: '종료 시간',
                              labelStyle: TextStyle(fontSize: 14),
                              floatingLabelBehavior: FloatingLabelBehavior.never, // Disable floating label
                              filled: true, // 배경색 적용
                              fillColor: Colors.grey[200], // 배경색 설정
                              border: OutlineInputBorder( // 텍스트 필드의 테두리 스타일 설정
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none, // 테두리 없음
                              ),
                            ),
                          ),
                        ),



                      ],
                    ),

                    SizedBox(height: 10.0),

                    Container(
                      // height: 150,
                      width: 300,
                      child: TextField(
                        onChanged: (String? value) {
                          memo = value;
                        },
                        maxLines: 8, // 메모를 작성할 수 있는 큰 필드로 설정 (원하는 줄 수로 조절)
                        decoration: InputDecoration(
                          alignLabelWithHint: true, // 라벨을 힌트와 정렬
                          labelText: '메모',
                          labelStyle: TextStyle(fontSize: 14),
                          floatingLabelBehavior: FloatingLabelBehavior.never, // Disable floating label
                          filled: true, // 배경색 적용
                          fillColor: Colors.grey[200], // 배경색 설정
                          border: OutlineInputBorder( // 텍스트 필드의 테두리 스타일 설정
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none, // 테두리 없음
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 8.0),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        // [저장] 버튼
                        // ➌ [저장] 버튼
                        onPressed: onSavePressed,
                        style: ElevatedButton.styleFrom(
                          primary: AppColor.yellowGreen,
                        ),
                        child: Text(
                          '저장',
                          style: TextStyle(
                            color: Colors.grey[800], // 진한 회색
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 8.0),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onSavePressed() async {
    if(_formkey.currentState!.validate()){ //폼 검증
      _formkey.currentState!.save(); //폼 저장

      // print(startTime);
      // print(endTime);
      // print(content);

      await GetIt.I<LocalDatabase>().createSchedule(
        SchedulesCompanion(
          startTime: Value(startTime!),
          endTime: Value(endTime!),
          content: Value(memo!),
          date: Value(widget.selectedDate),
        ),
      );

      Navigator.of(context).pop();
    }
  }

  String? timeValidator(String? val){ //시간 검증 함수
    if(val == null){
      return '값을 입력해주세요';
    }

    int? number;
    try{
      number=int.parse(val);
    }catch(e){
      return '숫자를 입력해주세요';
    }

    if (number<0||number>24){
      return '0시부터 24시 사이를 입력해주세요';
    }

    return null;
  }


  String? contentValidator(String? val){ //
    if (val==null||val.isEmpty==true){
      return '값을 입력해주세요';
    }

    return null;
  }

}






