import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import {DocumentSnapshot} from "firebase-functions/lib/providers/firestore";

export const onCreatePublication = functions
    .firestore
    .document("hubPublications/{publicationId}")
    // eslint-disable-next-line @typescript-eslint/no-unused-vars
    .onCreate((snap, _) => {
      return duplicatePublicationToFollowers(snap, Operation.Create);
    }
    );

export const onUpdatePublication = functions
    .firestore
    .document("hubPublications/{publicationId}")
    // eslint-disable-next-line @typescript-eslint/no-unused-vars
    .onUpdate((snap, _) => {
      return duplicatePublicationToFollowers(snap.after, Operation.Update);
    }
    );

export const onDeletePublication = functions
    .firestore
    .document("hubPublications/{publicationId}")
    // eslint-disable-next-line @typescript-eslint/no-unused-vars
    .onDelete((snap, _) => {
      return duplicatePublicationToFollowers(snap, Operation.Delete);
    }
    );

export async function duplicatePublicationToFollowers(snapshot: DocumentSnapshot, operation: Operation): Promise<any> {
  const hubId = await snapshot.get("hubId");
  if (hubId == null) return "Unable to find hubId for 'onCreatePublication' function";
  const followers = await admin
      .firestore()
      .collection(`hubsFollowers/${hubId}/users`)
      .get()
      .then((snap) => snap.docs.map((doc) => doc.id));
  const data = snapshot.data();
  if (data == undefined) return "Publication data is null, check why document snapshot is empty";
  switch (operation) {
    case Operation.Create:
      return Promise.all(
          followers.map((userId) =>
            admin.firestore().doc(`userFeeds/${userId}/publications/${snapshot.id}`).create(data)),
      );
    case Operation.Update:
      return Promise.all(
          followers.map((userId) =>
            admin.firestore().doc(`userFeeds/${userId}/publications/${snapshot.id}`).update(data)),
      );
    case Operation.Delete:
      return Promise.all(
          followers.map((userId) =>
            admin.firestore().doc(`userFeeds/${userId}/publications/${snapshot.id}`).delete(data)),
      );
  }
}

enum Operation {
    Create,
    Update,
    Delete
}
