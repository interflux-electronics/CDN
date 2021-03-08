const { series } = require("gulp");
const connect = require("gulp-connect");
const cors = require("cors");

function localhost() {
  connect.server({
    root: "public",
    port: 9000,
    middleware: function() {
      return [cors()];
    }
  });
}

const serve = series(localhost);

exports.serve = serve;
