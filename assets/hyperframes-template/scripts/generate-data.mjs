import fs from "node:fs";
import path from "node:path";

const root = process.cwd();
const dataDir = path.join(root, "data");
const filmPath = path.join(dataDir, "film.json");
const tokensPath = path.join(dataDir, "tokens.json");
const generatedPath = path.join(dataDir, "generated.js");

function readJson(file) {
  return JSON.parse(fs.readFileSync(file, "utf8"));
}

function writeJsonScript() {
  const film = readJson(filmPath);
  const tokens = readJson(tokensPath);
  const js = [
    "window.STUDIO_TOKENS = " + JSON.stringify(tokens, null, 2) + ";",
    "window.STUDIO_FILM = " + JSON.stringify(film, null, 2) + ";",
    "",
  ].join("\n");

  fs.writeFileSync(generatedPath, js);
  return film;
}

function updateHtml(file, duration, audio) {
  const filePath = path.join(root, file);
  let html = fs.readFileSync(filePath, "utf8");
  html = html.replace(/data-duration="[^"]+"/, `data-duration="${duration}"`);

  if (html.includes("<!-- studio-audio:start -->")) {
    html = html.replace(
      /<!-- studio-audio:start -->[\s\S]*?<!-- studio-audio:end -->/,
      audioBlock(audio, duration)
    );
  }

  fs.writeFileSync(filePath, html);
}

const film = writeJsonScript();
const fullDuration = Number(film?.meta?.totalDuration || 75);
const hookDuration = Math.min(15, fullDuration);
const hookAudio = normalizeAudio(film?.voice?.hookAudio || "audio/hook.mp3", "hook-audio", "hook");
const fullAudio = normalizeAudio(film?.voice?.fullAudio || "audio/voiceover.mp3", "voiceover-audio", "full");
const renderMode = process.env.STUDIO_RENDER_MODE || "none";

updateHtml("index.html", fullDuration, renderMode === "preview" ? htmlAudioFor("index.html", fullAudio) : null);
updateHtml("compositions/full.html", fullDuration, renderMode === "full" ? htmlAudioFor("compositions/full.html", fullAudio) : null);
updateHtml("compositions/hook.html", hookDuration, renderMode === "hook" ? htmlAudioFor("compositions/hook.html", hookAudio) : null);
updateHtml("compositions/design-thumbnail.html", 3, null);

function normalizeAudio(src, id, mode) {
  const clean = String(src || "").replace(/^\/+/, "").replace(/^public\//, "");
  return {
    id,
    mode,
    publicPath: clean,
    filePath: path.join(root, "public", clean),
  };
}

function htmlAudioFor(file, audio) {
  if (!audio || !fs.existsSync(audio.filePath)) return null;

  const prefix = file.startsWith("compositions/") ? "../public/" : "public/";
  return {
    id: audio.id,
    mode: audio.mode,
    src: prefix + audio.publicPath,
  };
}

function audioBlock(audio, duration) {
  if (!audio) {
    return "<!-- studio-audio:start --><!-- studio-audio:end -->";
  }

  return [
    "<!-- studio-audio:start -->",
    `      <audio id="${escapeAttr(audio.id)}" src="${escapeAttr(audio.src)}" data-start="0" data-duration="${duration}" data-track-index="20" data-volume="1" data-studio-audio="${escapeAttr(audio.mode)}"></audio>`,
    "      <!-- studio-audio:end -->",
  ].join("\n");
}

function escapeAttr(value) {
  return String(value)
    .replace(/&/g, "&amp;")
    .replace(/"/g, "&quot;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;");
}
