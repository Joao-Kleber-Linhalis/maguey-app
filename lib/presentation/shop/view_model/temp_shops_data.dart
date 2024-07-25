import 'package:magueyapp/presentation/shop/model/shop_model.dart';

List<ShopModel> shops = [
  ShopModel.fromJson(getData(1, "Shop A", applyTiming: false), "A"),
  ShopModel.fromJson(getData(2, "Shop B", applyTiming: false), "B"),
  ShopModel.fromJson(getData(3, "Shop C", applyTiming: true), "C"),
  ShopModel.fromJson(getData(4, "Shop D", applyTiming: false), "D"),
  ShopModel.fromJson(getData(5, "Shop E", applyTiming: true), "E"),
  ShopModel.fromJson(getData(6, "Shop F", applyTiming: true), "F"),
  ShopModel.fromJson(getData(7, "Shop G", applyTiming: false), "G"),
  ShopModel.fromJson(getData(8, "Shop H", applyTiming: false), "H"),
  ShopModel.fromJson(getData(9, "Shop I", applyTiming: true), "I"),
  ShopModel.fromJson(getData(10, "Shop J", applyTiming: true), "J"),
];

Map<String, dynamic> getData(int id, String name, {bool applyTiming = false}) {
  json['id'] = id;
  json['name'] = name;
  if (applyTiming) {
    json["timings"] = {"opening_time": "09:30 am", "closing_time": "05:40 pm"};
  }

  return json;
}

Map<String, dynamic> json = {
  "id": 1,
  "name": "Shop A",
  "image_url": "",
  "location": {
    "town_name": "Abc Colony California",
    "latitude": 37.42778777192896,
    "longitude": -122.17007073201927,
    "address": "I am the address"
  },
  "contact": "",
  "business_type": "Retail",
  "description":
      "asld;fjasd fasldkfjasdf asdjflaksdjf asdklfjasd falsdfjalsd faslkfjlasdfj lasdjflasjf asdljflasdjfasldfjalksdjflasd fasldfljfdflasjdflasdjflasd fasdfkjalsd faslkjflasdf jasldkfjalsdfj lkjasldfj asldkfj",
  "create_date": DateTime.now().toString(),
};

List<Map<String, dynamic>> shopsData = [
  {
    "name": "Louies Liquor",
    "business_type": "Retail",
    "image_url": "",
    "location": {
      "latitude": "34.13318532150804",
      "longitude": "-117.90031916217049",
      "address": "596 E Foothill Blvd, Azusa, CA 91702",
      "city": "Azusa",
      "state": "CA",
    },
    "timings": {"opening_time": "", "closing_time": ""},
    "description": "",
    "contact": "(626) 969-4528",
  },
  {
    "name": "Beverage Warehouse",
    "business_type": "Retail",
    "image_url": "",
    "location": {
      "latitude": "33.98298992992336",
      "longitude": "-118.42389380450558",
      "address": "4935 McConell Ave Suite 21, LA, CA 90066",
      "city": "Los Angeles",
      "state": "CA",
    },
    "timings": {"opening_time": "", "closing_time": ""},
    "description": "",
    "contact": "(310) 306-2822",
  },
  {
    "name": "Bar Keeper",
    "business_type": "Retail",
    "image_url": "",
    "location": {
      "latitude": "34.08212847517048",
      "longitude": "-118.28428561984539",
      "address": "614 N Hoover St",
      "city": "Los Angeles",
      "state": "CA",
    },
    "timings": {"opening_time": "", "closing_time": ""},
    "description": "",
    "contact": "(323) 669-1675",
  },
  {
    "name": "Vendome Liquors",
    "business_type": "Retail",
    "image_url": "",
    "location": {
      "latitude": "33.88960265327215",
      "longitude": "-117.87116824869098",
      "address": "3115 Yorba Linda Blvd, Fullerton, CA 92831",
      "city": "Fullerton",
      "state": "CA",
    },
    "timings": {"opening_time": "", "closing_time": ""},
    "description": "",
    "contact": "(714) 524-0800",
  },
  {
    "name": "Hi-Time Wine Cellars",
    "business_type": "Retail",
    "image_url": "",
    "location": {
      "latitude": "33.633035700460134",
      "longitude": "-117.91788389103085",
      "address": "250 Ogle St, Costa Mesa, CA 92627",
      "city": "Costa Mesa",
      "state": "CA",
    },
    "timings": {"opening_time": "", "closing_time": ""},
    "description": "",
    "contact": "(949) 650-8463",
  },
  {
    "name": "Ramirez Beverage Center - Los Angeles",
    "business_type": "Retail",
    "image_url": "",
    "location": {
      "latitude": "34.02393450212267",
      "longitude": "-118.21811459101215",
      "address": "2765 E. Olympic Blvd, Los Angeles, CA 90023",
      "city": "Los Angeles",
      "state": "CA",
    },
    "timings": {"opening_time": "", "closing_time": ""},
    "description": "",
    "contact": "(323) 266-2337",
  },
  {
    "name": "Ramirez Beverage Center - Pico Rivera",
    "business_type": "Retail",
    "image_url": "",
    "location": {
      "latitude": "33.968800726641184",
      "longitude": "-118.09626060450613",
      "address": "9419 Slauson Ave, Pico Rivera, CA 90660",
      "city": "Pico Rivera",
      "state": "CA",
    },
    "timings": {"opening_time": "", "closing_time": ""},
    "description": "",
    "contact": "(562) 222-2337",
  },
];
