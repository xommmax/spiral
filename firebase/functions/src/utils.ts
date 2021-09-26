import * as admin from "firebase-admin";
import * as express from "express";
import * as functions from "firebase-functions";

export const isEmulator = process.env.FUNCTIONS_EMULATOR === "true";

export async function validateFirebaseIdToken(req: express.Request, res: express.Response): Promise<admin.auth.DecodedIdToken | null> {
  if ((!req.headers.authorization || !req.headers.authorization.startsWith("Bearer ")) &&
        !(req.cookies && req.cookies.__session)) {
    functions.logger.error(
        "No Firebase ID token was passed as a Bearer token in the Authorization header.",
        "Make sure you authorize your request by providing the following HTTP header:",
        "Authorization: Bearer <Firebase ID Token>",
        "or by passing a \"__session\" cookie."
    );
    res.status(403).send("Unauthorized");
    return null;
  }

  let idToken;
  if (req.headers.authorization && req.headers.authorization.startsWith("Bearer ")) {
    idToken = req.headers.authorization.split("Bearer ")[1];
  } else if (req.cookies) {
    idToken = req.cookies.__session;
  } else {
    res.status(403).send("Unauthorized");
    return null;
  }

  try {
    return admin.auth().verifyIdToken(idToken);
  } catch (error) {
    functions.logger.error("Error while verifying Firebase ID token:", error);
    res.status(403).send("Unauthorized");
    return null;
  }
}
