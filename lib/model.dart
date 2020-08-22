class Posts {
  final String istilah;
  final String arti;

  Posts({this.istilah, this.arti});

  factory Posts.formJson(Map <String, dynamic> json){
    return new Posts(
       istilah: json['istilah'],
       arti: json['arti'],
    );
  }
}
