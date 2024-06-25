*&---------------------------------------------------------------------*
*& Include          ZEA_PP110TOP
*&---------------------------------------------------------------------*

TABLES: ZEA_PLAF, ZEA_T001W, ZEA_SDT030, ZEA_PPT010, ZEA_SDT020,
        ZEA_MMT010, ZEA_MMT020.

CONSTANTS: GC_CALC_MPS   TYPE STRING VALUE 'MPS_CALC',
           GC_NO_FILTER  TYPE STRING VALUE 'NO_FILTER',
           GC_NO_USE_MPS TYPE STRING VALUE 'NO_USE_FILTER',
           GC_USE_MPS    TYPE STRING VALUE 'USE_FILTER'.


*-- 트리 사용에 있어 필요한 변수 모음
*-- 노드 구성 변수
DATA: BEGIN OF GS_HEADER,
        SP_YEAR LIKE ZEA_SDT030-SP_YEAR,  " 판매계획 년도
        BUKRS   LIKE ZEA_T001W-BUKRS,     " 회사코드
        WERKS   LIKE ZEA_SDT030-WERKS,     " 플랜트 ID
        PNAME1  LIKE ZEA_T001W-BUKRS,     " 플랜트명
        MATNR   LIKE ZEA_SDT030-MATNR,    " 자재코드
        MAKTX   LIKE ZEA_MMT020-MAKTX,   " 자재명
      END OF GS_HEADER,
      GT_HEADER LIKE TABLE OF GS_HEADER.

DATA: BEGIN OF GS_HEADER2,
        PDPDAT LIKE ZEA_PLAF-PDPDAT,
        BUKRS  LIKE ZEA_T001W-BUKRS,
*        WERKS_PROD LIKE ZEA_T001W-WERKS,
        WERKS  LIKE ZEA_T001W-WERKS,
        PNAME1 LIKE ZEA_T001W-PNAME1,
        MATNR  LIKE ZEA_SDT030-MATNR,
        MAKTX  LIKE ZEA_MMT020-MAKTX,
      END OF GS_HEADER2,
      GT_HEADER2 LIKE TABLE OF GS_HEADER2.

*-- AVL 띄우기 위한 변수
DATA: BEGIN OF GS_DISPLAY,
        BUKRS   LIKE ZEA_T001W-BUKRS,     " 회사코드
        WERKS   LIKE ZEA_T001W-WERKS,     " 플랜트 ID
        PNAME1  LIKE ZEA_T001W-PNAME1,     " 플랜트명
        MATNR   LIKE ZEA_MMT010-MATNR,    " 자재코드
        MAKTX   LIKE ZEA_MMT010-MATNR,    " 자재명
        SAPNR   LIKE ZEA_SDT020-SAPNR,    " 판매계획 번호
        SP_YEAR LIKE ZEA_SDT020-SP_YEAR,  " 판매 년도
        SAPQU   LIKE ZEA_SDT030-SAPQU,    " 판매계획 수량
        MEINS   LIKE ZEA_SDT030-MEINS,    " 단위
        TOTREV  LIKE ZEA_SDT020-TOTREV,   " 목표 매출
        WAERS   LIKE ZEA_SDT020-WAERS,    " 통화코드
        SPQTY1  LIKE ZEA_SDT030-SPQTY1,   " 1월 판매계획 수량
        SPQTY2  LIKE ZEA_SDT030-SPQTY2,   " 2월 판매계획 수량
        SPQTY3  LIKE ZEA_SDT030-SPQTY3,   " 3월 판매계획 수량
        SPQTY4  LIKE ZEA_SDT030-SPQTY4,   " 4월 판매계획 수량
        SPQTY5  LIKE ZEA_SDT030-SPQTY5,   " 5월 판매계획 수량
        SPQTY6  LIKE ZEA_SDT030-SPQTY6,   " 6월 판매계획 수량
        SPQTY7  LIKE ZEA_SDT030-SPQTY7,   " 7월 판매계획 수량
        SPQTY8  LIKE ZEA_SDT030-SPQTY8,   " 8월 판매계획 수량
        SPQTY9  LIKE ZEA_SDT030-SPQTY9,   " 9월 판매계획 수량
        SPQTY10 LIKE ZEA_SDT030-SPQTY10,  " 10월 판매계획 수량
        SPQTY11 LIKE ZEA_SDT030-SPQTY11,  " 11월 판매계획 수량
        SPQTY12 LIKE ZEA_SDT030-SPQTY12,  " 12월 판매계획 수량

      END OF GS_DISPLAY,

      GT_DISPLAY LIKE TABLE OF GS_DISPLAY.

DATA: BEGIN OF GS_DISPLAY2,
        STATUS    LIKE ICON-ID, " 아이콘
        PLANID    LIKE ZEA_PPT010-PLANID,
        PLANINDEX LIKE ZEA_PPT010-PLANINDEX,
        PDPDAT    LIKE ZEA_PLAF-PDPDAT,
        WERKS     LIKE ZEA_T001W-WERKS,      " 플랜트 ID
        PNAME1    LIKE ZEA_T001W-PNAME1,     " 플랜트명
        MATNR     LIKE ZEA_PPT010-MATNR,
        MAKTX     LIKE ZEA_MMT020-MAKTX,
        BOMID     LIKE ZEA_PPT010-BOMID,
        PLANQTY1  LIKE ZEA_PPT010-PLANQTY1,
        PLANQTY2  LIKE ZEA_PPT010-PLANQTY2,
        PLANQTY3  LIKE ZEA_PPT010-PLANQTY3,
        PLANQTY4  LIKE ZEA_PPT010-PLANQTY4,
        PLANQTY5  LIKE ZEA_PPT010-PLANQTY5,
        PLANQTY6  LIKE ZEA_PPT010-PLANQTY6,
        PLANQTY7  LIKE ZEA_PPT010-PLANQTY7,
        PLANQTY8  LIKE ZEA_PPT010-PLANQTY8,
        PLANQTY9  LIKE ZEA_PPT010-PLANQTY9,
        PLANQTY10 LIKE ZEA_PPT010-PLANQTY10,
        PLANQTY11 LIKE ZEA_PPT010-PLANQTY11,
        PLANQTY12 LIKE ZEA_PPT010-PLANQTY12,
        TOTAL     TYPE ZEA_PPT010-PLANQTY1,
        MEINS     LIKE ZEA_PPT010-MEINS,
        LOEKZ     LIKE ZEA_PPT010-LOEKZ,
        LIGHT     TYPE C,                    " 신호등 표시를 위한
      END OF GS_DISPLAY2,

      GT_DISPLAY2 LIKE TABLE OF GS_DISPLAY2.

*-- 조건을 만족하는 값을 띄위기 위한 변수
DATA: BEGIN OF GS_NODE_INFO,
        NODE_KEY LIKE MTREESNODE-NODE_KEY,
        SP_YEAR  LIKE ZEA_SDT020-SP_YEAR,  " 판매 년도
        BUKRS    LIKE ZEA_T001W-BUKRS,     " 회사코드
        WERKS    LIKE ZEA_T001W-WERKS,     " 플랜트 ID
        MATNR    LIKE ZEA_MMT010-MATNR,    " 자재코드
      END OF GS_NODE_INFO,

      GT_NODE_INFO LIKE TABLE OF GS_NODE_INFO.

DATA: BEGIN OF GS_NODE_INFO2,
        NODE_KEY LIKE MTREESNODE-NODE_KEY,
        PDPDAT   LIKE ZEA_PLAF-PDPDAT,
        BUKRS    LIKE ZEA_T001W-BUKRS,
*        WERKS_PROD LIKE ZEA_T001W-WERKS,
        WERKS    LIKE ZEA_T001W-WERKS,
        PNAME1   LIKE ZEA_T001W-PNAME1,
        MATNR    LIKE ZEA_SDT030-MATNR,
        MAKTX    LIKE ZEA_MMT020-MAKTX,
      END OF GS_NODE_INFO2,

      GT_NODE_INFO2 LIKE TABLE OF GS_NODE_INFO2.

*-- 0120 화면 변수

DATA: BEGIN OF S0120,
        PLANQTY1  LIKE ZEA_PPT010-PLANQTY1,
        PLANQTY2  LIKE ZEA_PPT010-PLANQTY2,
        PLANQTY3  LIKE ZEA_PPT010-PLANQTY3,
        PLANQTY4  LIKE ZEA_PPT010-PLANQTY4,
        PLANQTY5  LIKE ZEA_PPT010-PLANQTY5,
        PLANQTY6  LIKE ZEA_PPT010-PLANQTY6,
        PLANQTY7  LIKE ZEA_PPT010-PLANQTY7,
        PLANQTY8  LIKE ZEA_PPT010-PLANQTY8,
        PLANQTY9  LIKE ZEA_PPT010-PLANQTY9,
        PLANQTY10 LIKE ZEA_PPT010-PLANQTY10,
        PLANQTY11 LIKE ZEA_PPT010-PLANQTY11,
        PLANQTY12 LIKE ZEA_PPT010-PLANQTY12,
        1MONTH    TYPE C,
        2MONTH    TYPE C,
        3MONTH    TYPE C,
        4MONTH    TYPE C,
        5MONTH    TYPE C,
        6MONTH    TYPE C,
        7MONTH    TYPE C,
        8MONTH    TYPE C,
        9MONTH    TYPE C,
        10MONTH   TYPE C,
        11MONTH   TYPE C,
        12MONTH   TYPE C,
        UNIT      TYPE ZEA_PPT010-MEINS,
      END OF S0120.

*-- 생산계획에 대해 이미 생성된 계획인지 확인하기 위한 변수 집합
DATA : BEGIN OF GS_CHECK,
         PLANID    TYPE ZEA_PLAF-PLANID,
         PDPDAT    TYPE ZEA_PLAF-PDPDAT,
         WERKS     TYPE ZEA_PLAF-WERKS,
         PLANINDEX TYPE ZEA_PPT010-PLANINDEX,
         MATNR     TYPE ZEA_PPT010-MATNR,
         SAPNR     TYPE ZEA_PLAF-SAPNR,
*           PLANQTY1  TYPE ZEA_PPT010-PLANQTY1,
*           PLANQTY2  TYPE ZEA_PPT010-PLANQTY2,
*           PLANQTY3  TYPE ZEA_PPT010-PLANQTY3,
*           PLANQTY4  TYPE ZEA_PPT010-PLANQTY4,
*           PLANQTY5  TYPE ZEA_PPT010-PLANQTY5,
*           PLANQTY6  TYPE ZEA_PPT010-PLANQTY6,
*           PLANQTY7  TYPE ZEA_PPT010-PLANQTY7,
*           PLANQTY8  TYPE ZEA_PPT010-PLANQTY8,
*           PLANQTY9  TYPE ZEA_PPT010-PLANQTY9,
*           PLANQTY10 TYPE ZEA_PPT010-PLANQTY10,
*           PLANQTY11 TYPE ZEA_PPT010-PLANQTY11,
*           PLANQTY12 TYPE ZEA_PPT010-PLANQTY12,
*           MEINS     TYPE ZEA_PPT010-MEINS,
         LOEKZ     TYPE ZEA_PPT010-LOEKZ,
       END OF GS_CHECK.
DATA GT_CHECK LIKE TABLE OF GS_CHECK.



*-- SCREEN 관련 변수
CONSTANTS: GC_CUSTOM_CONTAINER_NAME_TOP TYPE SCRFNAME VALUE 'CCON'.
CONSTANTS: GC_CUSTOM_CONTAINER_NAME_BOT TYPE SCRFNAME VALUE 'CCON2'.
DATA: OK_CODE TYPE SY-UCOMM.

DATA: GO_DOCK_CON_L         TYPE REF TO CL_GUI_DOCKING_CONTAINER, " TREE용
      GO_DOCK_CON_R         TYPE REF TO CL_GUI_DOCKING_CONTAINER, " TREE용
      GO_DOCK               TYPE REF TO CL_GUI_DOCKING_CONTAINER, " ALV 세부 데이터용
      GO_DOCK2              TYPE REF TO CL_GUI_DOCKING_CONTAINER, " ALV 세부 데이터용
      GT_DOCK               LIKE TABLE OF GO_DOCK,                " GO_DOCK을 쌓아둘 ITAB
      GT_DOCK2              LIKE TABLE OF GO_DOCK,                " GO_DOCK을 쌓아둘 ITAB
      GO_CON_TOP            TYPE REF TO CL_GUI_CUSTOM_CONTAINER,
      GO_CON_BOT            TYPE REF TO CL_GUI_CUSTOM_CONTAINER,
      GO_SPLIT_TOP          TYPE REF TO CL_GUI_SPLITTER_CONTAINER,
      GO_SPLIT_BOT          TYPE REF TO CL_GUI_SPLITTER_CONTAINER,

      GO_CON_TOP_TREE       TYPE REF TO CL_GUI_CONTAINER,
      GO_CON_TOP_GRID       TYPE REF TO CL_GUI_CONTAINER,

      GO_CON_BOT_TREE       TYPE REF TO CL_GUI_CONTAINER,
      GO_CON_BOT_GRID       TYPE REF TO CL_GUI_CONTAINER,

      GO_SIMPLE_TREE        TYPE REF TO CL_GUI_SIMPLE_TREE,
      GO_SIMPLE_TREE2       TYPE REF TO CL_GUI_SIMPLE_TREE,
      GO_ALV_GRID_TOP       TYPE REF TO CL_GUI_ALV_GRID,
      GO_ALV_GRID_BOT       TYPE REF TO CL_GUI_ALV_GRID.

*-- ALV 관련 변수
DATA: GS_LAYOUT    TYPE LVC_S_LAYO,
      GS_LAYOUT2   TYPE LVC_S_LAYO,
      GT_FIELDCAT  TYPE LVC_T_FCAT,
      GS_FIELDCAT  LIKE LINE OF GT_FIELDCAT,
      GT_FIELDCAT2 TYPE LVC_T_FCAT,
      GS_FIELDCAT2 LIKE LINE OF GT_FIELDCAT,
      GT_SORT      TYPE LVC_T_SORT,
      GS_SORT      LIKE LINE OF GT_SORT,
      GT_SORT2     TYPE LVC_T_SORT,
      GS_SORT2     LIKE LINE OF GT_SORT,
      GS_VARIANT   TYPE DISVARIANT,
      GV_SAVE      TYPE C,
      GV_LINES     TYPE SY-TFILL,
      GV_CHECK     TYPE C,
      GT_FILTER    TYPE LVC_T_FILT,
      GS_FILTER    TYPE LVC_S_FILT.



*-- TREE 관련 변수
DATA: GV_NODE_KEY  TYPE N LENGTH 6,
      GV_NODE_KEY2 TYPE N LENGTH 6.

DATA: BEGIN OF GS_NODE,
        NODE_KEY   TYPE MTREESNODE-NODE_KEY,
        RELATKEY   TYPE MTREESNODE-RELATKEY,
        RELATSHIP  TYPE MTREESNODE-RELATSHIP,
        HIDDEN     TYPE MTREESNODE-HIDDEN,
        DISABLED   TYPE MTREESNODE-DISABLED,
        ISFOLDER   TYPE MTREESNODE-ISFOLDER,
        N_IMAGE    TYPE MTREESNODE-N_IMAGE,
        EXP_IMAGE  TYPE MTREESNODE-EXP_IMAGE,
        STYLE      TYPE MTREESNODE-STYLE,
        LAST_HITEM TYPE MTREESNODE-LAST_HITEM,
        NO_BRANCH  TYPE MTREESNODE-NO_BRANCH,
        EXPANDER   TYPE MTREESNODE-EXPANDER,
        DRAGDROPID TYPE MTREESNODE-DRAGDROPID,
        TEXT       TYPE CHAR60,
      END OF GS_NODE.
DATA: GT_NODE     LIKE TABLE OF GS_NODE.

DATA: BEGIN OF GS_NODE2,
        NODE_KEY   TYPE MTREESNODE-NODE_KEY,
        RELATKEY   TYPE MTREESNODE-RELATKEY,
        RELATSHIP  TYPE MTREESNODE-RELATSHIP,
        HIDDEN     TYPE MTREESNODE-HIDDEN,
        DISABLED   TYPE MTREESNODE-DISABLED,
        ISFOLDER   TYPE MTREESNODE-ISFOLDER,
        N_IMAGE    TYPE MTREESNODE-N_IMAGE,
        EXP_IMAGE  TYPE MTREESNODE-EXP_IMAGE,
        STYLE      TYPE MTREESNODE-STYLE,
        LAST_HITEM TYPE MTREESNODE-LAST_HITEM,
        NO_BRANCH  TYPE MTREESNODE-NO_BRANCH,
        EXPANDER   TYPE MTREESNODE-EXPANDER,
        DRAGDROPID TYPE MTREESNODE-DRAGDROPID,
        TEXT       TYPE CHAR60,
      END OF GS_NODE2.
DATA: GT_NODE2     LIKE TABLE OF GS_NODE2.

*----------------------------------------------------------------------*
* Common MACRO
*----------------------------------------------------------------------*
DEFINE _MC_POPUP_CONFIRM.
  CALL FUNCTION 'POPUP_TO_CONFIRM'
    EXPORTING
      TITLEBAR              = &1
*      DISPLAY_CANCEL_BUTTON = ''
      TEXT_QUESTION         = &2
      TEXT_BUTTON_1         = 'YES'
      ICON_BUTTON_1         = '@2K@'
      TEXT_BUTTON_2         = 'NO'
      ICON_BUTTON_2         = '@2O@ '
    IMPORTING
      ANSWER                = &3
    EXCEPTIONS
      TEXT_NOT_FOUND        = 1
      OTHERS                = 2.
END-OF-DEFINITION.
