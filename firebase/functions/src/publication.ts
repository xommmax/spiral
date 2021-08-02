import * as functions from "firebase-functions";
import * as express from "express";
import {log} from "firebase-functions/lib/logger";
import * as admin from "firebase-admin";


export const fetchPublications = functions.https.onRequest(async (req: express.Request, res: express.Response)=> {
  try {
    const hubId = req.path.replace("/", "");
    const docs = await admin.firestore()
        .collection("hubPublications")
        .where("hubId", "==", hubId)
        .get()
        .then((snapshot) => snapshot.docs);
    const json = await getPublications(docs);
    res.status(200).send(json);
  } catch (e) {
    log("An error occurred while running 'fetchPublications' request: " + e + "\nstacktrace is: " + e.trace);
    res.status(422).send("Something went wrong, please try again.");
  }
});

export async function getPublications(docs: Array<FirebaseFirestore.DocumentSnapshot>):
    Promise<Array<FirebaseFirestore.DocumentData>> {
  const publications = <Array<FirebaseFirestore.DocumentData>>[];
  await Promise.all(docs.map((doc) => getPublication(doc))).then((result) => {
    for (const publication of result) {
      if (publication != undefined) {
        publications.push(publication);
      }
    }
  });
  return publications;
}

export async function getPublication(doc: FirebaseFirestore.DocumentSnapshot): Promise<FirebaseFirestore.DocumentData|undefined> {
  const snap = admin.firestore().doc(`hubPublications/${doc.id}`);
  const result = await snap.get().then((result) => result.data());
  if (result) {
    result["usersLiked"] = await usersLiked(doc);
    result["id"] = doc.id;
    return result;
  }
  return undefined;
}

export const usersLiked = (doc: FirebaseFirestore.DocumentSnapshot) : Promise<Array<string>> => doc.ref
    .collection("usersLiked")
    .get()
    .then((snap) => snap.docs.map((doc) => doc.id));

