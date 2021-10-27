import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import {DocumentSnapshot} from "firebase-functions/lib/providers/firestore";

export const onCreatePublication = functions
    .firestore
    .document("hubPublications/{publicationId}")
    // eslint-disable-next-line @typescript-eslint/no-unused-vars
    .onCreate((snap, _) => {
      return addPublicationToFollowersFeed(snap);
    }
    );

export const onDeletePublication = functions
    .firestore
    .document("hubPublications/{publicationId}")
    // eslint-disable-next-line @typescript-eslint/no-unused-vars
    .onDelete((snap, _) => {
      return deletePublicationFromFollowersFeed(snap);
    }
    );

export async function addPublicationToFollowersFeed(snapshot: DocumentSnapshot): Promise<any> {
  const hubId = await snapshot.get("hubId");
  if (hubId == null) return "Unable to find hubId for 'onCreatePublication' function";
  const followers = await admin
      .firestore()
      .collection(`hubsFollowers/${hubId}/users`)
      .get()
      .then((snap) => snap.docs.map((doc) => doc.id));
  return Promise.all(
      followers.map((userId) =>
        admin
            .firestore()
            .doc(`userFeeds/${userId}/publications/${snapshot.id}`)
            .create({"createdAt": snapshot.get("createdAt")}))
  );
}

export async function deletePublicationFromFollowersFeed(snapshot: DocumentSnapshot): Promise<any> {
  const hubId = await snapshot.get("hubId");
  if (hubId == null) return "Unable to find hubId for 'onCreatePublication' function";
  const followers = await admin
      .firestore()
      .collection(`hubsFollowers/${hubId}/users`)
      .get()
      .then((snap) => snap.docs.map((doc) => doc.id));
  return Promise.all(
      followers.map((userId) =>
        admin
            .firestore()
            .doc(`userFeeds/${userId}/publications/${snapshot.id}`)
            .delete())
  );
}
