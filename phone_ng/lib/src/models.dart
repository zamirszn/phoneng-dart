enum Network{
  unknown,
  mafab,
  airtel,
  mtn, ntel,
  glo,
  nineMobile,
  smile
}

enum EntryType{
  special,
  mobile,
  landline
}


class PrefixEntry{
  final Network network;
  final EntryType type;

  PrefixEntry({required this.network, required this.type});
}