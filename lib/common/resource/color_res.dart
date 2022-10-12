// ignore_for_file: constant_identifier_names

import 'dart:ui';

/// Ark Standard Color Resource
enum StandardColor {
  N1,// 背景色
  N2,// 文字
  N3,// 文字
  N4,// 文字
  N5,// 卡片色
  N6,// 分割线
  N7,// 分隔条
  O1,// 品牌色
  R1,// 色块红
  R2,// 文字红
  G1,// 色块绿
  G2,// 文字绿

  Base_Link,
  Base_Buy,// 买色
  Base_Sell,// 卖色

  Btn_Text,
  Btn_Disable_Text,
  Btn_Highlight_Bg,
  Btn_Disable_Bg,
  Item_Highlight_Bg,
  Divider_Deep,
  Tag_Highlight,
  Tag_Disable,
  Chart_Tag,
  Keyboard_Button_bg,
  Watchlist_Item_Shimmer_R_Start,
  Watchlist_Item_Shimmer_R_End,
  Watchlist_Item_Shimmer_G_Start,
  Watchlist_Item_Shimmer_G_End,
  Watchlist_Popup_Window_Bg,
  Watchlist_Popup_Window_Divider,
  Sliding_Segmented_Control_Thumb_Color,
}

extension ThemeColor on StandardColor {
  Color get color => _nightModeColorMap[this];

  Color get dayColor => _dayModeColorMap[this];

  Color getColor(bool dayTheme) => dayTheme ? dayColor : color;
}

const Map _nightModeColorMap = <StandardColor, Color> {
  StandardColor.N1: Color(0xFF080D12),
  StandardColor.N2: Color(0xFFE8E8E8),
  StandardColor.N3: Color(0xFF8E8E92),
  StandardColor.N4: Color(0xFF57595C),
  StandardColor.N5: Color(0xFF161A1D),
  StandardColor.N6: Color(0xFF282C34),
  StandardColor.N7: Color(0xFF282C34),
  StandardColor.O1: Color(0xFFF28203),
  StandardColor.R1: Color(0xFFEB4D3D),
  StandardColor.R2: Color(0xFFEB5141),
  StandardColor.G1: Color(0xFF55BE56),
  StandardColor.G2: Color(0xFF64C465),
  StandardColor.Base_Link: Color(0xFF3478F6),
  StandardColor.Base_Buy: Color(0xFFF28203),
  StandardColor.Base_Sell: Color(0xFF5570FC),
  StandardColor.Btn_Text: Color(0xFFFEFEFE),
  StandardColor.Btn_Disable_Text: Color(0xFFBEA385),
  StandardColor.Btn_Highlight_Bg: Color(0xFF7D480B),
  StandardColor.Btn_Disable_Bg: Color(0xFF7D480B),
  StandardColor.Item_Highlight_Bg: Color(0xFF1C1F22),
  StandardColor.Divider_Deep: Color(0xFF000000),
  StandardColor.Tag_Highlight: Color(0xFFF28203),
  StandardColor.Tag_Disable: Color(0xFF454C54),
  StandardColor.Chart_Tag: Color(0xFF1C2126),
  StandardColor.Keyboard_Button_bg: Color(0xFF2B2F36),
  StandardColor.Watchlist_Item_Shimmer_R_Start: Color(0x00D5331D),
  StandardColor.Watchlist_Item_Shimmer_R_End: Color(0x3DD5331D),
  StandardColor.Watchlist_Item_Shimmer_G_Start: Color(0x0009B364),
  StandardColor.Watchlist_Item_Shimmer_G_End: Color(0x3309B364),
  StandardColor.Watchlist_Popup_Window_Bg: Color(0xFF2E3338),
  StandardColor.Watchlist_Popup_Window_Divider: Color(0xFF636366),
  StandardColor.Sliding_Segmented_Control_Thumb_Color: Color(0xFF383E42),

};

const Map _dayModeColorMap = <StandardColor, Color> {
  StandardColor.N1: Color(0xFFFFFFFF),
  StandardColor.N2: Color(0xFF050D13),
  StandardColor.N3: Color(0xFF757371),
  StandardColor.N4: Color(0xFF9B9897),
  StandardColor.N5: Color(0xFFFFFFFF),
  StandardColor.N6: Color(0xFFF1F2F4),
  StandardColor.N7: Color(0xFFF8F7F7),
  StandardColor.O1: Color(0xFFFF9500),
  StandardColor.R1: Color(0xFFED5A31),
  StandardColor.R2: Color(0xFFEB4B1E),
  StandardColor.G1: Color(0xFF51C53A),
  StandardColor.G2: Color(0xFF4EBF38),
  StandardColor.Base_Link: Color(0xFF3478F6),
  StandardColor.Base_Buy: Color(0xFFF28203),
  StandardColor.Base_Sell: Color(0xFF5570FC),
  StandardColor.Btn_Text: Color(0xFFFFFFFF),
  StandardColor.Btn_Disable_Text: Color(0xFFFFFFFF),
  StandardColor.Btn_Highlight_Bg: Color(0xFFCC7700),
  StandardColor.Btn_Disable_Bg: Color(0xFFFFC97F),
  StandardColor.Item_Highlight_Bg: Color(0xFFF5F5F5),
  StandardColor.Divider_Deep: Color(0xFFF5F5F5),
  StandardColor.Tag_Highlight: Color(0xFFFF9500),
  StandardColor.Tag_Disable: Color(0xFFF5F5F5),
  StandardColor.Chart_Tag: Color(0xFFF5F5F5),
  StandardColor.Keyboard_Button_bg: Color(0xFFF5F5F5),
  StandardColor.Watchlist_Item_Shimmer_R_Start: Color(0x00D5331D),
  StandardColor.Watchlist_Item_Shimmer_R_End: Color(0x3DD5331D),
  StandardColor.Watchlist_Item_Shimmer_G_Start: Color(0x0009B364),
  StandardColor.Watchlist_Item_Shimmer_G_End: Color(0x3309B364),
  StandardColor.Watchlist_Popup_Window_Bg: Color(0xFFFFFFFF),
  StandardColor.Watchlist_Popup_Window_Divider: Color(0xFFF5F5F5),
  StandardColor.Sliding_Segmented_Control_Thumb_Color: Color(0xFFF5F5F5),

};