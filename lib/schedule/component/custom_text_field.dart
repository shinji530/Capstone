import 'package:capstone/schedule/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool isTime;   // 시간 선택하는 텍스트 필드인지 여부
  
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  
  const CustomTextField({
    required this.label,
    required this.isTime,
    required this.onSaved,
    required this.validator,

    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(  // ➋ 세로로 텍스트와 텍스트 필드를 위치
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColor.deepGreen,
            fontWeight: FontWeight.w600,
          ),
        ),
        Expanded(
          flex: isTime ? 0 : 1, // ➏
          child: Container(
            height: 40,
            child: TextFormField(
              onSaved: onSaved, // 폼 저장할 때 실핼할 함수
              validator: validator, //폼 검증했을 때 실행할 함수
              cursorColor: Colors.grey,    // 커서 색상 변경
              maxLines: isTime ? 1 : null, // ➊ 시간 관련 텍스트 필드가 아니면 한 줄이상 작성 가능
              expands: !isTime, // ➋ 시간 관련 텍스트 필드는 공간 최대 차지
              keyboardType: isTime ? TextInputType.number : TextInputType.multiline, // ➌ 시간 관련 텍스트 필드는 기본 숫자 키보드 아니면 일반 글자 키보드 보여주기
              inputFormatters: isTime
                  ? [
                FilteringTextInputFormatter.digitsOnly,
              ]
                  : [], // ➍ 시간 관련 텍스트 필드는 숫자만 입력하도록 제한
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none, // 테두리 삭제
                ),
                filled: true, // 배경색을 지정하겠다는 선언
                fillColor: Colors.grey[300],      // 배경색
                suffixText: isTime ? '시' : null, // ➎ 시간 관련 텍스트 필드는 ‘시' 접미사 추가
              ),
            ),
          ),
        ),
      ],
    );
  }
}
