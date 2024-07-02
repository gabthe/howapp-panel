// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'dart:typed_data';

import 'package:crop_image/crop_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:howapp_panel/src/model/activity.dart';
import 'package:howapp_panel/src/model/commercial_profile.dart';
import 'package:howapp_panel/src/model/event_tag.dart';
import 'package:howapp_panel/src/model/localization.dart';
import 'package:howapp_panel/src/repository/event_repo.dart';
import 'package:howapp_panel/src/repository/localization_repo.dart';
import 'package:howapp_panel/src/repository/user_repo.dart';
import 'package:howapp_panel/src/utils/api_state.dart';

class CreateEventViewmodel {
  ApiState fetchingAllProfileState;
  List<EventTag> allEventTags;
  List<EventTag> selectedEventTags;
  EventTag? mainEventTag;
  CommercialProfile? selectedEventCreator;
  List<CommercialProfile> allComercialProfileList;
  Uint8List? pickedBanner;
  Uint8List? pickedPhoto;
  Uint8List? pickedCarrocelBigImage;
  Uint8List? pickedCarrocelSmallImage;
  Uint8List? pickedLinearBanner;
  CropController photoCropController;
  CropController bannerCropController;
  CropController carrocelBigImageCropController;
  CropController carrocelSmallImageCropController;
  CropController linearBannerCropController;
  TextEditingController searchInputController;
  GoogleMapController? googleMapController;
  Set<Marker> googleMapMarker;
  Localization? selectedLocalization;
  TextEditingController eventNameController;
  List<Activity> listOfEventActivities;
  TextEditingController activityNameController;
  int selectedDay;
  int selectedMonth;
  int selectedYear;
  int selectedHour;
  int selectedMinute;
  int activityStartDay;
  int activityStartMonth;
  int activityStartYear;
  int activityStartHour;
  int activityStartMinute;

  bool changedDateOnce;

  String eventNameOnChangeString;
  TextEditingController eventDescriptionController;

  String eventDescritionOnChangeString;

  CreateEventViewmodel({
    required this.fetchingAllProfileState,
    required this.allEventTags,
    required this.selectedEventTags,
    this.mainEventTag,
    this.selectedEventCreator,
    required this.allComercialProfileList,
    this.pickedBanner,
    this.pickedPhoto,
    this.pickedCarrocelBigImage,
    this.pickedCarrocelSmallImage,
    this.pickedLinearBanner,
    required this.photoCropController,
    required this.bannerCropController,
    required this.carrocelBigImageCropController,
    required this.carrocelSmallImageCropController,
    required this.linearBannerCropController,
    required this.searchInputController,
    this.googleMapController,
    required this.googleMapMarker,
    this.selectedLocalization,
    required this.eventNameController,
    required this.listOfEventActivities,
    required this.activityNameController,
    required this.selectedDay,
    required this.selectedMonth,
    required this.selectedYear,
    required this.selectedHour,
    required this.selectedMinute,
    required this.activityStartDay,
    required this.activityStartMonth,
    required this.activityStartYear,
    required this.activityStartHour,
    required this.activityStartMinute,
    required this.changedDateOnce,
    required this.eventNameOnChangeString,
    required this.eventDescriptionController,
    required this.eventDescritionOnChangeString,
  });

  CreateEventViewmodel copyWith({
    ApiState? fetchingAllProfileState,
    List<EventTag>? allEventTags,
    List<EventTag>? selectedEventTags,
    EventTag? mainEventTag,
    CommercialProfile? selectedEventCreator,
    List<CommercialProfile>? allComercialProfileList,
    Uint8List? pickedBanner,
    Uint8List? pickedPhoto,
    Uint8List? pickedCarrocelBigImage,
    Uint8List? pickedCarrocelSmallImage,
    Uint8List? pickedLinearBanner,
    CropController? photoCropController,
    CropController? bannerCropController,
    CropController? carrocelBigImageCropController,
    CropController? carrocelSmallImageCropController,
    CropController? linearBannerCropController,
    TextEditingController? searchInputController,
    GoogleMapController? googleMapController,
    Set<Marker>? googleMapMarker,
    Localization? selectedLocalization,
    TextEditingController? eventNameController,
    List<Activity>? listOfEventActivities,
    TextEditingController? activityNameController,
    int? selectedDay,
    int? selectedMonth,
    int? selectedYear,
    int? selectedHour,
    int? selectedMinute,
    int? activityStartDay,
    int? activityStartMonth,
    int? activityStartYear,
    int? activityStartHour,
    int? activityStartMinute,
    bool? changedDateOnce,
    String? eventNameOnChangeString,
    TextEditingController? eventDescriptionController,
    String? eventDescritionOnChangeString,
  }) {
    return CreateEventViewmodel(
      fetchingAllProfileState:
          fetchingAllProfileState ?? this.fetchingAllProfileState,
      allEventTags: allEventTags ?? this.allEventTags,
      selectedEventTags: selectedEventTags ?? this.selectedEventTags,
      mainEventTag: mainEventTag ?? this.mainEventTag,
      selectedEventCreator: selectedEventCreator ?? this.selectedEventCreator,
      allComercialProfileList:
          allComercialProfileList ?? this.allComercialProfileList,
      pickedBanner: pickedBanner ?? this.pickedBanner,
      pickedPhoto: pickedPhoto ?? this.pickedPhoto,
      pickedCarrocelBigImage:
          pickedCarrocelBigImage ?? this.pickedCarrocelBigImage,
      pickedCarrocelSmallImage:
          pickedCarrocelSmallImage ?? this.pickedCarrocelSmallImage,
      pickedLinearBanner: pickedLinearBanner ?? this.pickedLinearBanner,
      photoCropController: photoCropController ?? this.photoCropController,
      bannerCropController: bannerCropController ?? this.bannerCropController,
      carrocelBigImageCropController:
          carrocelBigImageCropController ?? this.carrocelBigImageCropController,
      carrocelSmallImageCropController: carrocelSmallImageCropController ??
          this.carrocelSmallImageCropController,
      linearBannerCropController:
          linearBannerCropController ?? this.linearBannerCropController,
      searchInputController:
          searchInputController ?? this.searchInputController,
      googleMapController: googleMapController ?? this.googleMapController,
      googleMapMarker: googleMapMarker ?? this.googleMapMarker,
      selectedLocalization: selectedLocalization ?? this.selectedLocalization,
      eventNameController: eventNameController ?? this.eventNameController,
      listOfEventActivities:
          listOfEventActivities ?? this.listOfEventActivities,
      activityNameController:
          activityNameController ?? this.activityNameController,
      selectedDay: selectedDay ?? this.selectedDay,
      selectedMonth: selectedMonth ?? this.selectedMonth,
      selectedYear: selectedYear ?? this.selectedYear,
      selectedHour: selectedHour ?? this.selectedHour,
      selectedMinute: selectedMinute ?? this.selectedMinute,
      activityStartDay: activityStartDay ?? this.activityStartDay,
      activityStartMonth: activityStartMonth ?? this.activityStartMonth,
      activityStartYear: activityStartYear ?? this.activityStartYear,
      activityStartHour: activityStartHour ?? this.activityStartHour,
      activityStartMinute: activityStartMinute ?? this.activityStartMinute,
      changedDateOnce: changedDateOnce ?? this.changedDateOnce,
      eventNameOnChangeString:
          eventNameOnChangeString ?? this.eventNameOnChangeString,
      eventDescriptionController:
          eventDescriptionController ?? this.eventDescriptionController,
      eventDescritionOnChangeString:
          eventDescritionOnChangeString ?? this.eventDescritionOnChangeString,
    );
  }
}

class CreateEventViewmodelNotifier extends StateNotifier<CreateEventViewmodel> {
  final UserRepo userRepo;
  final LocalizationRepository localizationRepo;
  final EventRepo eventRepo;
  CreateEventViewmodelNotifier({
    required this.localizationRepo,
    required this.userRepo,
    required this.eventRepo,
  }) : super(
          CreateEventViewmodel(
            allComercialProfileList: [],
            eventNameController: TextEditingController(),
            eventDescriptionController: TextEditingController(),
            allEventTags: [],
            selectedEventTags: [],
            photoCropController: CropController(
              aspectRatio: 1,
            ),
            fetchingAllProfileState: ApiState.idle,
            bannerCropController: CropController(
              aspectRatio: 16 / 9,
            ),
            searchInputController: TextEditingController(),
            googleMapMarker: {},
            eventDescritionOnChangeString: '',
            eventNameOnChangeString: '',
            selectedDay: DateTime.now().day,
            selectedMonth: DateTime.now().month,
            selectedYear: DateTime.now().year,
            selectedHour: DateTime.now().hour,
            selectedMinute: DateTime.now().minute,
            activityStartDay: DateTime.now().day,
            activityStartMonth: DateTime.now().month,
            activityStartYear: DateTime.now().year,
            activityStartHour: DateTime.now().hour,
            activityStartMinute: DateTime.now().minute,
            changedDateOnce: false,
            listOfEventActivities: [],
            activityNameController: TextEditingController(),
            carrocelBigImageCropController: CropController(
              aspectRatio: 1,
            ),
            carrocelSmallImageCropController: CropController(
              aspectRatio: 1,
            ),
            linearBannerCropController: CropController(
              aspectRatio: 1,
            ),
          ),
        ) {
    init();
  }
  init() async {
    try {
      state = state.copyWith(fetchingAllProfileState: ApiState.pending);
      List<CommercialProfile> commercialProfileList =
          await userRepo.getAllComercialProfiles();
      List<EventTag> allEventTags = await eventRepo.getAllEventTags();

      state = state.copyWith(
        allComercialProfileList: commercialProfileList,
        allEventTags: allEventTags,
        fetchingAllProfileState: ApiState.succeeded,
      );
    } catch (e, st) {
      log('create_event_viewmodel', error: e, stackTrace: st);
      state = state.copyWith(fetchingAllProfileState: ApiState.error);
    }
  }

  setEventBanner(Uint8List eventBannerUint8) {
    state = state.copyWith(pickedBanner: eventBannerUint8);
  }

  setEventPhoto(Uint8List eventPhotoUint8) {
    state = state.copyWith(pickedPhoto: eventPhotoUint8);
  }

  setEventBigCarrouselImage(Uint8List imageMemory) {
    state = state.copyWith(pickedCarrocelBigImage: imageMemory);
  }

  setEventSmalllCarrouselImage(Uint8List imageMemory) {
    state = state.copyWith(pickedCarrocelSmallImage: imageMemory);
  }

  setEventLinearBannerlImage(Uint8List imageMemory) {
    state = state.copyWith(pickedLinearBanner: imageMemory);
  }

  eventNameOnChange(String string) {
    state = state.copyWith(eventNameOnChangeString: string);
  }

  setStartTime({
    int? day,
    int? month,
    int? year,
    int? hour,
    int? minute,
  }) {
    print('$day $month $year $hour $minute');
    state = state.copyWith(
      selectedDay: day ?? state.selectedDay,
      selectedMonth: month ?? state.selectedMonth,
      selectedYear: year ?? state.selectedYear,
      selectedHour: hour ?? state.selectedHour,
      selectedMinute: minute ?? state.selectedMinute,
      changedDateOnce: true,
    );
  }

  setActivityStartTime({
    int? day,
    int? month,
    int? year,
    int? hour,
    int? minute,
  }) {
    print('$day $month $year $hour $minute');
    state = state.copyWith(
      activityStartDay: day ?? state.activityStartDay,
      activityStartMonth: month ?? state.activityStartMonth,
      activityStartYear: year ?? state.activityStartYear,
      activityStartHour: hour ?? state.activityStartHour,
      activityStartMinute: minute ?? state.activityStartMinute,
    );
  }

  addNewActivity(Activity newActivity) {
    var canAdd = !state.listOfEventActivities.any(
      (element) {
        return element.id == newActivity.id;
      },
    );
    if (canAdd) {
      state = state.copyWith(
        listOfEventActivities: [...state.listOfEventActivities, newActivity],
      );
    }
  }

  removeActivity(Activity activity) {
    state = state.copyWith(
      listOfEventActivities: state.listOfEventActivities
          .where(
            (element) => element.id != activity.id,
          )
          .toList(),
    );
  }

  eventDescriptionOnChange(String string) {
    state = state.copyWith(eventDescritionOnChangeString: string);
  }

  addNewTagToEvent(EventTag eventTag) {
    var canAddTag = !state.selectedEventTags.any(
      (element) {
        return element.id == eventTag.id;
      },
    );
    if (canAddTag) {
      state = state.copyWith(
        selectedEventTags: [...state.selectedEventTags, eventTag],
      );
    }
  }

  removeTagFromEvent(EventTag eventTag) {
    state = state.copyWith(
      selectedEventTags: state.selectedEventTags.where(
        (element) {
          return element.id != eventTag.id;
        },
      ).toList(),
    );
  }

  setMainEventTag(EventTag selectedTag) {
    state = state.copyWith(mainEventTag: selectedTag);
  }

  setMapController(GoogleMapController newController) {
    state = state.copyWith(googleMapController: newController);
  }

  setEventCreator(CommercialProfile eventCreator) {
    state = state.copyWith(selectedEventCreator: eventCreator);
  }

  Future<Localization> _setSelectedLocalization(LatLng latlng) async {
    try {
      var newLocalization = await localizationRepo.getAddress(latlng);
      state = state.copyWith(
        selectedLocalization: newLocalization,
      );
      return newLocalization;
    } catch (e, st) {
      log('create_event_viewmodel_error', error: e, stackTrace: st);
      rethrow;
    }
  }

  createNewMarkerInMap(LatLng tappedPoint) async {
    try {
      var localization = await _setSelectedLocalization(tappedPoint);
      final markerId = MarkerId(tappedPoint.toString());
      var marker = Marker(
        markerId: markerId,
        position: tappedPoint,
        infoWindow: InfoWindow(
          title: 'Localização selecionada',
          snippet: localization.fullAddress,
        ),
      );
      state = state.copyWith(googleMapMarker: {marker});
    } catch (e, st) {
      log('create_event_viewmodel_error', error: e, stackTrace: st);
      rethrow;
    }
  }

  findPlaceFromInput() async {
    try {
      var newLocation = await localizationRepo.getAdressByInput(
        state.searchInputController.text,
      );
      if (newLocation == null) {
        throw 'Local não encontrado';
      }
      state.googleMapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(newLocation.lat, newLocation.lng),
            zoom: 18,
          ),
        ),
      );
    } catch (e, st) {
      log('create_event_viewmodel_error', error: e, stackTrace: st);
      rethrow;
    }
  }
}

final createEventViewmodelProvider = StateNotifierProvider.autoDispose<
    CreateEventViewmodelNotifier, CreateEventViewmodel>((ref) {
  return CreateEventViewmodelNotifier(
    localizationRepo: ref.watch(locationRepositoryProvider),
    userRepo: ref.watch(userRepoProvider),
    eventRepo: ref.watch(eventRepoProvider),
  );
});
