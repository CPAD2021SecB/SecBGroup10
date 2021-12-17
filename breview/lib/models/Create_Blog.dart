import 'dart:math';

class BlogDetails {
  String id;
  String blogDesc;
  String blogImageUrl;
  String profilePictureUrl;

  int likes;
  String username;

  BlogDetails(this.id, this.blogDesc, this.createdAt);

  String createdAt;

  Map<String, dynamic> toMap() {
    profilePictureUrl = getProfilePicture();
    likes = 0;
    username = "Rajat";

    return {
      "user_id": id,
      "image": blogImageUrl,
      "Blog_text": blogDesc,
      "ProfilePictureUrl": profilePictureUrl,
      "likes": likes,
      "username": username
    };
  }

  getProfilePicture() {
    List<String> pictures = [
      "https://i.picsum.photos/id/1027/2848/4272.jpg?hmac=EAR-f6uEqI1iZJjB6-NzoZTnmaX0oI0th3z8Y78UpKM",
      "https://firebasestorage.googleapis.com/v0/b/breview-334103.appspot.com/o/userImg%2Fhorse-profile-g753f81d39_1920.jpg?alt=media&token=adf3ea79-851f-4aa4-aee8-65dc91c761ca",
      "https://firebasestorage.googleapis.com/v0/b/breview-334103.appspot.com/o/userImg%2Fhead-g696c383e5_1920.jpg?alt=media&token=cf109c6a-5d10-4690-aa47-c4e05d9ea9a",
      "https://firebasestorage.googleapis.com/v0/b/breview-334103.appspot.com/o/userImg%2Fprofile-picture-g36e9ceda8_1920.jpg?alt=media&token=0dcaa8b1-ce5f-4e0e-901d-dcfb74187ac3",
      "https://firebasestorage.googleapis.com/v0/b/breview-334103.appspot.com/o/userImg%2Fsunset-geee407f9d_1920.jpg?alt=media&token=dd62d617-d0d8-401e-9282-a617436cfeff",
      "https://firebasestorage.googleapis.com/v0/b/breview-334103.appspot.com/o/userImg%2Fturkey-g16712ae03_1280.jpg?alt=media&token=2dbb935f-49ee-4ab9-ad4e-6070048c485e",
      "https://firebasestorage.googleapis.com/v0/b/breview-334103.appspot.com/o/blogImg%2Fimage.jfif?alt=media&token=ca1d4df1-c810-40fc-aeb1-3eac0fa418c9",
      "https://firebasestorage.googleapis.com/v0/b/breview-334103.appspot.com/o/blogImg%2Fimage2.jfif?alt=media&token=3af1f673-471c-4aed-9eb9-652ff21df248"
    ];

    return pictures[new Random().nextInt(pictures.length)];
  }
}
