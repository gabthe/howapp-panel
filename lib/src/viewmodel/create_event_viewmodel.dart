// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'dart:typed_data';

import 'package:crop_image/crop_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';

import 'package:howapp_panel/src/model/activity.dart';
import 'package:howapp_panel/src/model/commercial_profile.dart';
import 'package:howapp_panel/src/model/event.dart';
import 'package:howapp_panel/src/model/event_tag.dart';
import 'package:howapp_panel/src/model/localization.dart';
import 'package:howapp_panel/src/repository/event_repo.dart';
import 'package:howapp_panel/src/repository/localization_repo.dart';
import 'package:howapp_panel/src/repository/user_repo.dart';
import 'package:howapp_panel/src/utils/api_state.dart';
import 'package:howapp_panel/src/utils/image_url_to_uint8list.dart';

class CreateEventViewmodel {
  ApiState creatingEventInFirestore;
  ApiState fetchingAllProfileState;
  ApiState fetchingEventData;
  List<EventTag> allEventTags;
  List<EventTag> selectedEventTags;
  EventTag? mainEventTag;
  CommercialProfile? selectedEventCreator;
  List<CommercialProfile> allComercialProfileList;
  Uint8List? pickedBanner;
  Uint8List? pickedPhoto;
  Uint8List? pickedCarouselBigImage;
  Uint8List? pickedCarouselSmallImage;
  Uint8List? pickedCardImage;
  CropController photoCropController;
  CropController bannerCropController;
  CropController carouselBigImageCropController;
  CropController carouselSmallImageCropController;
  CropController cardImageCropController;
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
  bool hasTicketSelling;
  bool hasHowStore;
  bool useCreatorPhotoAsEventPhoto;
  bool changedDateOnce;
  String eventNameOnChangeString;
  TextEditingController eventDescriptionController;
  String eventDescritionOnChangeString;
  bool eventIsHighlighted;
  int? highlightIndex;
  CreateEventViewmodel({
    required this.creatingEventInFirestore,
    required this.fetchingAllProfileState,
    required this.fetchingEventData,
    required this.allEventTags,
    required this.selectedEventTags,
    this.mainEventTag,
    this.selectedEventCreator,
    required this.allComercialProfileList,
    this.pickedBanner,
    this.pickedPhoto,
    this.pickedCarouselBigImage,
    this.pickedCarouselSmallImage,
    this.pickedCardImage,
    required this.photoCropController,
    required this.bannerCropController,
    required this.carouselBigImageCropController,
    required this.carouselSmallImageCropController,
    required this.cardImageCropController,
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
    required this.hasTicketSelling,
    required this.hasHowStore,
    required this.useCreatorPhotoAsEventPhoto,
    required this.changedDateOnce,
    required this.eventNameOnChangeString,
    required this.eventDescriptionController,
    required this.eventDescritionOnChangeString,
    required this.eventIsHighlighted,
    this.highlightIndex,
  });

  CreateEventViewmodel copyWith({
    ApiState? creatingEventInFirestore,
    ApiState? fetchingAllProfileState,
    ApiState? fetchingEventData,
    List<EventTag>? allEventTags,
    List<EventTag>? selectedEventTags,
    EventTag? mainEventTag,
    CommercialProfile? selectedEventCreator,
    List<CommercialProfile>? allComercialProfileList,
    Uint8List? pickedBanner,
    Uint8List? pickedPhoto,
    Uint8List? pickedCarouselBigImage,
    Uint8List? pickedCarouselSmallImage,
    Uint8List? pickedCardImage,
    CropController? photoCropController,
    CropController? bannerCropController,
    CropController? carouselBigImageCropController,
    CropController? carouselSmallImageCropController,
    CropController? cardImageCropController,
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
    bool? hasTicketSelling,
    bool? hasHowStore,
    bool? useCreatorPhotoAsEventPhoto,
    bool? changedDateOnce,
    String? eventNameOnChangeString,
    TextEditingController? eventDescriptionController,
    String? eventDescritionOnChangeString,
    bool? eventIsHighlighted,
    int? highlightIndex,
  }) {
    return CreateEventViewmodel(
      creatingEventInFirestore:
          creatingEventInFirestore ?? this.creatingEventInFirestore,
      fetchingAllProfileState:
          fetchingAllProfileState ?? this.fetchingAllProfileState,
      fetchingEventData: fetchingEventData ?? this.fetchingEventData,
      allEventTags: allEventTags ?? this.allEventTags,
      selectedEventTags: selectedEventTags ?? this.selectedEventTags,
      mainEventTag: mainEventTag ?? this.mainEventTag,
      selectedEventCreator: selectedEventCreator ?? this.selectedEventCreator,
      allComercialProfileList:
          allComercialProfileList ?? this.allComercialProfileList,
      pickedBanner: pickedBanner ?? this.pickedBanner,
      pickedPhoto: pickedPhoto ?? this.pickedPhoto,
      pickedCarouselBigImage:
          pickedCarouselBigImage ?? this.pickedCarouselBigImage,
      pickedCarouselSmallImage:
          pickedCarouselSmallImage ?? this.pickedCarouselSmallImage,
      pickedCardImage: pickedCardImage ?? this.pickedCardImage,
      photoCropController: photoCropController ?? this.photoCropController,
      bannerCropController: bannerCropController ?? this.bannerCropController,
      carouselBigImageCropController:
          carouselBigImageCropController ?? this.carouselBigImageCropController,
      carouselSmallImageCropController: carouselSmallImageCropController ??
          this.carouselSmallImageCropController,
      cardImageCropController:
          cardImageCropController ?? this.cardImageCropController,
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
      hasTicketSelling: hasTicketSelling ?? this.hasTicketSelling,
      hasHowStore: hasHowStore ?? this.hasHowStore,
      useCreatorPhotoAsEventPhoto:
          useCreatorPhotoAsEventPhoto ?? this.useCreatorPhotoAsEventPhoto,
      changedDateOnce: changedDateOnce ?? this.changedDateOnce,
      eventNameOnChangeString:
          eventNameOnChangeString ?? this.eventNameOnChangeString,
      eventDescriptionController:
          eventDescriptionController ?? this.eventDescriptionController,
      eventDescritionOnChangeString:
          eventDescritionOnChangeString ?? this.eventDescritionOnChangeString,
      eventIsHighlighted: eventIsHighlighted ?? this.eventIsHighlighted,
      highlightIndex: highlightIndex ?? this.highlightIndex,
    );
  }
}

class CreateEventViewmodelNotifier extends StateNotifier<CreateEventViewmodel> {
  final UserRepo userRepo;
  final LocalizationRepository localizationRepo;
  final EventRepo eventRepo;
  final String? eventId;
  final bool isExperience;
  CreateEventViewmodelNotifier({
    required this.localizationRepo,
    required this.userRepo,
    required this.eventRepo,
    required this.isExperience,
    this.eventId,
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
            carouselBigImageCropController: CropController(
              aspectRatio: 1,
            ),
            carouselSmallImageCropController: CropController(
              aspectRatio: 1,
            ),
            cardImageCropController: CropController(
              aspectRatio: 20 / 3,
            ),
            hasHowStore: false,
            hasTicketSelling: false,
            useCreatorPhotoAsEventPhoto: false,
            creatingEventInFirestore: ApiState.idle,
            eventIsHighlighted: false,
            fetchingEventData: ApiState.idle,
          ),
        ) {
    init();
  }
  init() async {
    try {
      state = state.copyWith(
        fetchingAllProfileState: ApiState.pending,
        fetchingEventData: ApiState.pending,
      );
      List<CommercialProfile> commercialProfileList =
          await userRepo.getAllComercialProfiles();
      List<EventTag> allEventTags = await eventRepo.getAllEventTags();

      if (eventId != null) {
        var event = await eventRepo.fetchEventById(eventId!);
        var localization = await localizationRepo
            .getAddress(LatLng(event!.latitude, event.longitude));
        var photoUrl = await imageUrlToUint8List(event.photoUrl);
        var bannerUrl = await imageUrlToUint8List(event.bannerUrl);
        var carouselBigUrl = await imageUrlToUint8List(event.carouselBigUrl);
        var carouselSmallUrl = await imageUrlToUint8List(
          event.carouselSmallUrl,
        );
        var cardImageUrl = await imageUrlToUint8List(
          event.cardImageUrl,
        );

        state = state.copyWith(
          eventNameOnChangeString: event.name,
          eventDescritionOnChangeString: event.description,
          selectedDay: event.date.day,
          selectedMonth: event.date.month,
          selectedYear: event.date.year,
          selectedHour: event.date.hour,
          selectedMinute: event.date.minute,
          selectedLocalization: localization,
          pickedPhoto: photoUrl,
          pickedBanner: bannerUrl,
          pickedCarouselBigImage: carouselBigUrl,
          pickedCarouselSmallImage: carouselSmallUrl,
          selectedEventCreator: commercialProfileList.firstWhere((e) {
            return e.id == event.creatorId;
          }),
          selectedEventTags: event.eventTags,
          listOfEventActivities: event.activities,
          hasHowStore: event.hasHowStore,
          hasTicketSelling: event.hasTicketSelling,
          changedDateOnce: true,
          eventIsHighlighted: event.isHighlighted,
          highlightIndex: event.highlightIndex,
          pickedCardImage: cardImageUrl,
        );
        var locationLatLng = LatLng(
          state.selectedLocalization!.lat,
          state.selectedLocalization!.lng,
        );
        final markerId = MarkerId(
          locationLatLng.toString(),
        );
        var marker = Marker(
          markerId: markerId,
          position: locationLatLng,
          infoWindow: InfoWindow(
            title: 'Localização selecionada',
            snippet: localization.fullAddress,
          ),
        );
        state = state.copyWith(googleMapMarker: {marker});
      }

      state = state.copyWith(
        allComercialProfileList: commercialProfileList,
        allEventTags: allEventTags,
        fetchingAllProfileState: ApiState.succeeded,
        fetchingEventData: ApiState.succeeded,
      );
    } catch (e, st) {
      log('create_event_viewmodel', error: e, stackTrace: st);
      state = state.copyWith(
        fetchingAllProfileState: ApiState.error,
        fetchingEventData: ApiState.error,
      );
    }
  }

  toggleTicketSelling() {
    state = state.copyWith(hasTicketSelling: !state.hasTicketSelling);
  }

  toggleHasHowStore() {
    state = state.copyWith(hasHowStore: !state.hasHowStore);
  }

  toggleUseCreatorPhotoAsEventPhoto() {
    state = state.copyWith(
      useCreatorPhotoAsEventPhoto: !state.useCreatorPhotoAsEventPhoto,
    );
  }

  setEventBanner(Uint8List eventBannerUint8) {
    state = state.copyWith(pickedBanner: eventBannerUint8);
  }

  setEventPhoto(Uint8List eventPhotoUint8) {
    state = state.copyWith(pickedPhoto: eventPhotoUint8);
  }

  setEventBigCarouselImage(Uint8List imageMemory) {
    state = state.copyWith(pickedCarouselBigImage: imageMemory);
  }

  setEventSmallCarouselImage(Uint8List imageMemory) {
    state = state.copyWith(pickedCarouselSmallImage: imageMemory);
  }

  setEventCardImage(Uint8List imageMemory) {
    state = state.copyWith(pickedCardImage: imageMemory);
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

  String? validateEventForm() {
    if (state.selectedEventCreator == null) {
      return 'Erro: Criador do evento não selecionado.';
    }
    if (state.eventNameOnChangeString.isEmpty) {
      return 'Erro: Nome do evento não preenchido.';
    }
    if (state.eventDescritionOnChangeString.isEmpty) {
      return 'Erro: Descrição do evento não preenchida.';
    }
    if (state.selectedLocalization == null) {
      return 'Erro: Localização do evento não selecionada.';
    }
    if (!state.changedDateOnce) {
      return 'Erro: Data do evento não preenchida.';
    }
    if (!state.useCreatorPhotoAsEventPhoto && state.pickedPhoto == null) {
      return 'Erro: Foto do evento não carregada.';
    }
    if (state.pickedBanner == null) {
      return 'Erro: Banner do evento não carregado.';
    }
    if (state.pickedCarouselBigImage == null) {
      return 'Erro: Imagem grande do carrossel do evento não carregada.';
    }
    if (state.pickedCarouselSmallImage == null) {
      return 'Erro: Imagem pequena do carrossel do evento não carregada.';
    }
    if (state.pickedCardImage == null) {
      return 'Erro: Imagem de card não carregada.';
    }
    if (state.listOfEventActivities.isEmpty) {
      return 'Erro: Atividades do evento não adicionadas.';
    }
    if (state.selectedEventTags.isEmpty) {
      return 'Erro: Tags do evento não selecionadas.';
    }

    return null;
  }

  createEvent() async {
    try {
      state = state.copyWith(creatingEventInFirestore: ApiState.pending);
      String profilePhotoUrl;
      if (state.useCreatorPhotoAsEventPhoto) {
        profilePhotoUrl = state.selectedEventCreator!.profilePictureUrl;
      } else {
        profilePhotoUrl = await eventRepo.uploadEventImageToFirestorage(
          memoryImage: state.pickedPhoto!,
          eventName: state.eventNameOnChangeString
              .trim()
              .toLowerCase()
              .replaceAll(' ', '_'),
          imageType: ImageType.profile,
          imageName: DateTime.now().toString(),
        );
      }

      var bannerPhotoUrl = await eventRepo.uploadEventImageToFirestorage(
        memoryImage: state.pickedBanner!,
        eventName: state.eventNameOnChangeString
            .trim()
            .toLowerCase()
            .replaceAll(' ', '_'),
        imageType: ImageType.banner,
        imageName: DateTime.now().toString(),
      );
      var carouselBigUrl = await eventRepo.uploadEventImageToFirestorage(
        memoryImage: state.pickedCarouselBigImage!,
        eventName: state.eventNameOnChangeString
            .trim()
            .toLowerCase()
            .replaceAll(' ', '_'),
        imageType: ImageType.carouselBig,
        imageName: DateTime.now().toString(),
      );
      var carouselSmallUrl = await eventRepo.uploadEventImageToFirestorage(
        memoryImage: state.pickedCarouselSmallImage!,
        eventName: state.eventNameOnChangeString
            .trim()
            .toLowerCase()
            .replaceAll(' ', '_'),
        imageType: ImageType.carouselSmall,
        imageName: DateTime.now().toString(),
      );
      var cardImageUrl = await eventRepo.uploadEventImageToFirestorage(
        memoryImage: state.pickedCardImage!,
        eventName: state.eventNameOnChangeString
            .trim()
            .toLowerCase()
            .replaceAll(' ', '_'),
        imageType: ImageType.cardImage,
        imageName: DateTime.now().toString(),
      );
      var event = Event(
        id: eventId ?? const Uuid().v4(),
        creatorId: state.selectedEventCreator!.id,
        creatorName: state.selectedEventCreator!.name,
        creatorUsername: state.selectedEventCreator!.username,
        creatorProfilePictureUrl: state.selectedEventCreator!.profilePictureUrl,
        creatorBannerPictureUrl: state.selectedEventCreator!.bannerPictureUrl,
        photoUrl: profilePhotoUrl,
        bannerUrl: bannerPhotoUrl,
        carouselSmallUrl: carouselSmallUrl,
        carouselBigUrl: carouselBigUrl,
        cardImageUrl: cardImageUrl,
        name: state.eventNameOnChangeString,
        description: state.eventDescritionOnChangeString,
        fullAdress: state.selectedLocalization!.fullAddress,
        latitude: state.selectedLocalization!.lat,
        longitude: state.selectedLocalization!.lng,
        isExperience: isExperience,
        date: DateTime.utc(
          state.selectedYear,
          state.selectedMonth,
          state.selectedDay,
          state.selectedHour,
          state.selectedMinute,
        ),
        hasTicketSelling: state.hasTicketSelling,
        hasHowStore: state.hasHowStore,
        activities: state.listOfEventActivities,
        eventTags: state.selectedEventTags,
        interestedList: [],
        isHighlighted: state.eventIsHighlighted,
        highlightIndex: state.highlightIndex,
      );
      await eventRepo.createEventInFirestore(
        isExperience: isExperience,
        event: event,
      );
      state = state.copyWith(creatingEventInFirestore: ApiState.succeeded);
    } catch (e, st) {
      log('create-event-viewmodel-error', error: e, stackTrace: st);
      state = state.copyWith(creatingEventInFirestore: ApiState.error);

      rethrow;
    }
  }
}

final createEventViewmodelProvider = StateNotifierProvider.autoDispose.family<
    CreateEventViewmodelNotifier,
    CreateEventViewmodel,
    CreateEventViewmodelParams>((ref, params) {
  return CreateEventViewmodelNotifier(
    eventId: params.eventId,
    isExperience: params.isExperience,
    localizationRepo: ref.watch(locationRepositoryProvider),
    userRepo: ref.watch(userRepoProvider),
    eventRepo: ref.watch(eventRepoProvider),
  );
});

class CreateEventViewmodelParams {
  String? eventId;
  bool isExperience;
  CreateEventViewmodelParams({
    required this.eventId,
    required this.isExperience,
  });

  @override
  bool operator ==(covariant CreateEventViewmodelParams other) {
    if (identical(this, other)) return true;

    return other.eventId == eventId && other.isExperience == isExperience;
  }

  @override
  int get hashCode => eventId.hashCode ^ isExperience.hashCode;
}
