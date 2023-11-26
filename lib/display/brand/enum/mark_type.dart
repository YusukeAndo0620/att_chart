enum MarkType {
  gap,
  news,
}

extension MarkTypeExtension on MarkType {
  String get text {
    switch (this) {
      case MarkType.gap:
        return 'G';
      case MarkType.news:
        return 'N';
    }
  }
}

MarkType getMarkType({required String value}) {
  switch (value) {
    case '0':
      return MarkType.gap;
    case '1':
      return MarkType.news;
    default:
      return MarkType.gap;
  }
}
