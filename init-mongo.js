db = db.getSiblingDB("mydatabase");

db.createUser({
  user: "appuser",
  pwd: "apppassword",
  roles: [
    {
      role: "readWrite",
      db: "mydatabase",
    },
  ],
});
