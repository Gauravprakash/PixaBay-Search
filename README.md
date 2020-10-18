# PixaBay-Search

This project is used to search image based on user enter the query . upon tapping on Image A detailed view will open where users can slide forward and backward of the images.

PixaBay-Search

This Application is based on VIPER architecture for clean separation of different layers.

Networking

This application use URLSession based API

Image Downloading

Image downloading is using URLSession along with Operation subclass tied to OperationQueue for easy management of image downloading.

Search History

To Save Search Keywords (up to 10) , CoreData class has been used and if it goes above 10, will replace with first keyword saved.
