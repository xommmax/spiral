import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

export const onFollowingHub = functions
    .firestore
    .document("usersFollowHubs/{userId}/hubs/{hubId}")
// eslint-disable-next-line @typescript-eslint/no-unused-vars
    .onCreate(async (snap, _) => {
      const userId = snap.ref.parent.parent?.id;
      const hubId = snap.id;
      if (userId == undefined) return;
      await updateFollowingsCount(true, userId);
      return addFollowedHubPublicationsToFeed(hubId, userId);
    });

export const onUnfollowingHub = functions
    .firestore
    .document("usersFollowHubs/{userId}/hubs/{hubId}")
// eslint-disable-next-line @typescript-eslint/no-unused-vars
    .onDelete(async (snap, _) => {
      const userId = snap.ref.parent.parent?.id;
      const hubId = snap.id;
      if (userId == undefined) return;
      await updateFollowingsCount(false, userId);
      return deleteUnfollowedHubPublicationsFromFeed(hubId, userId);
    });


export async function updateFollowingsCount(isFollowing: boolean, userId: string): Promise<any> {
  const snap = admin.firestore().doc(`users/${userId}`);
  if (isFollowing) {
    return snap.update({"followingsCount": admin.firestore.FieldValue.increment(1)});
  } else {
    return snap.update({"followingsCount": admin.firestore.FieldValue.increment(-1)});
  }
}

export async function addFollowedHubPublicationsToFeed(hubId: string, userId: string): Promise<any> {
  const publications = await admin.firestore().collection("hubPublications")
      .where("hubId", "==", hubId)
      .get();

  for (const publication of publications.docs) {
    await admin
        .firestore()
        .doc(`userFeeds/${userId}/publications/${publication.id}`)
        .create({"createdAt": publication.get("createdAt")});
  }
}

export async function deleteUnfollowedHubPublicationsFromFeed(hubId: string, userId: string): Promise<any> {
  const publications = await admin.firestore().collection("hubPublications")
      .where("hubId", "==", hubId)
      .get();

  for (const publication of publications.docs) {
    await admin
        .firestore()
        .doc(`userFeeds/${userId}/publications/${publication.id}`)
        .delete();
  }
}
