abstract class FavoritesStates {}

class FavoritesInitState extends FavoritesStates {}

class AddToFavorites extends FavoritesStates {}

class ErrorAddToFavorites extends FavoritesStates {}

class RemoveFromFavorites extends FavoritesStates {}

class ErrorRemoveFromFavorites extends FavoritesStates {}

class GetFavorites extends FavoritesStates {}

class ErrorGetFavorites extends FavoritesStates {}

class ToggleFavoriteSuccessStatewithoutget extends FavoritesStates {}
