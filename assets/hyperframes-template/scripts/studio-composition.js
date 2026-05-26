(function () {
  const film = window.STUDIO_FILM || {};
  const tokens = window.STUDIO_TOKENS || {};
  const root = document.querySelector("[data-composition-id]");

  if (!root) {
    throw new Error("Missing HyperFrames composition root.");
  }

  const compositionId = root.getAttribute("data-composition-id");
  const mode = root.getAttribute("data-mode") || "full";
  const width = Number(root.getAttribute("data-width") || 1920);
  const height = Number(root.getAttribute("data-height") || 1080);
  const totalDuration = Number(root.getAttribute("data-duration") || film?.meta?.totalDuration || 75);
  const colors = normalizeColors(tokens.color);
  const type = normalizeType(tokens.typography);

  applyColorVariables(root, colors);

  if (mode === "design-thumbnail") {
    buildDesignThumbnail(root, film, colors);
  } else {
    buildFilm(root, film, mode, totalDuration);
  }

  applyTypography(root, type);

  window.__timelines = window.__timelines || {};
  window.__studioTimeline = buildTimeline(root, mode, totalDuration);
  window.__timelines[compositionId] = window.__studioTimeline;

  function normalizeColors(color = {}) {
    return {
      background: color.background || "#F4EFE6",
      ink: color.ink || "#1A1614",
      accent: color.accent || "#2E6F5E",
      support: color.support || "#C9B89A",
      surface: color.surface || "#FFF9EF",
      muted: color.muted || "#6F675E",
    };
  }

  function normalizeType(typography = {}) {
    const display = typography.display || {};
    const body = typography.body || {};
    const mono = typography.mono || {};
    return {
      display: `"${display.family || "Inter"}", ${display.fallback || "system-ui, sans-serif"}`,
      displayWeight: display.weight || 720,
      body: `"${body.family || "Inter"}", ${body.fallback || "system-ui, sans-serif"}`,
      bodyWeight: body.weight || 400,
      mono: `"${mono.family || "JetBrains Mono"}", ${mono.fallback || "ui-monospace, monospace"}`,
      monoWeight: mono.weight || 400,
    };
  }

  function applyColorVariables(target, color) {
    target.style.setProperty("--bg", color.background);
    target.style.setProperty("--ink", color.ink);
    target.style.setProperty("--accent", color.accent);
    target.style.setProperty("--support", color.support);
    target.style.setProperty("--surface", color.surface);
    target.style.setProperty("--muted", color.muted);
  }

  function applyTypography(target, typography) {
    target.style.fontFamily = typography.body;
    target.style.fontWeight = typography.bodyWeight;

    target.querySelectorAll("h1, h2").forEach((el) => {
      el.style.fontFamily = typography.display;
      el.style.fontWeight = typography.displayWeight;
    });

    target.querySelectorAll(".eyebrow, .motion-note, .proof-card strong").forEach((el) => {
      el.style.fontFamily = typography.mono;
      el.style.fontWeight = typography.monoWeight;
    });
  }

  function buildDesignThumbnail(target, data, color) {
    const projectName = data?.meta?.projectName || "Untitled";
    const variant = label(data?.meta?.variant || "concept-film");
    const firstSection = (data.sections || [])[0] || {};
    const phrase = firstSection?.sceneProps?.kineticPhrase || firstSection?.vo || "Make the concept legible.";

    target.innerHTML = `
      <div id="design-card" class="design-card" data-start="0" data-duration="3" data-track-index="1">
        <div class="design-rule"></div>
        <div class="eyebrow">${escapeHtml(variant)} direction</div>
        <h1>${escapeHtml(projectName)}</h1>
        <p>${escapeHtml(phrase)}</p>
        <div class="palette" aria-hidden="true">
          <span style="background:${color.background}"></span>
          <span style="background:${color.ink}"></span>
          <span style="background:${color.accent}"></span>
          <span style="background:${color.support}"></span>
        </div>
      </div>
    `;
  }

  function buildFilm(target, data, renderMode, duration) {
    const sections = selectSections(data.sections || [], renderMode, duration);
    const audio = renderMode === "hook" ? data?.voice?.hookAudio : data?.voice?.fullAudio;
    const audioId = renderMode === "hook" ? "hook-audio" : "voiceover-audio";
    const existingAudio = target.querySelector("audio[data-studio-audio]");

    target.innerHTML = "";
    sections.forEach((section, index) => {
      target.appendChild(renderSection(section, index, duration));
    });

    if (existingAudio) {
      existingAudio.setAttribute("data-duration", String(duration));
      target.appendChild(existingAudio);
    } else if (audio) {
      const audioEl = document.createElement("audio");
      audioEl.id = audioId;
      audioEl.setAttribute("data-start", "0");
      audioEl.setAttribute("data-duration", String(duration));
      audioEl.setAttribute("data-track-index", "20");
      audioEl.setAttribute("data-volume", "1");
      audioEl.setAttribute("data-studio-audio", renderMode);
      audioEl.src = asset(audio);
      target.appendChild(audioEl);
    }
  }

  function selectSections(sections, renderMode, maxDuration) {
    const sorted = sections.slice().sort((a, b) => Number(a.start || 0) - Number(b.start || 0));

    if (renderMode !== "hook") {
      return sorted;
    }

    return sorted
      .filter((section) => Number(section.start || 0) < maxDuration)
      .map((section) => {
        const copy = { ...section };
        const start = Number(copy.start || 0);
        copy.duration = Math.max(0.5, Math.min(Number(copy.duration || 1), maxDuration - start));
        return copy;
      });
  }

  function renderSection(section, index) {
    const props = section.sceneProps || {};
    const sectionEl = document.createElement("section");
    sectionEl.id = sanitizeId(section.id || `section-${index + 1}`);
    sectionEl.className = `scene scene-${sanitizeId(section.sceneType || "generic")}`;
    sectionEl.setAttribute("data-start", String(Number(section.start || 0)));
    sectionEl.setAttribute("data-duration", String(Number(section.duration || 1)));
    sectionEl.setAttribute("data-track-index", "1");
    sectionEl.dataset.sceneIndex = String(index);

    const visual = resolveVisual(props);
    const chips = [
      props.beforeState && ["Before", props.beforeState],
      props.afterState && ["After", props.afterState],
      props.productProof && ["Proof", props.productProof],
    ].filter(Boolean);

    sectionEl.innerHTML = `
      <div class="scene-content">
        <div class="scene-copy">
          <div class="eyebrow">${escapeHtml(props.eyebrow || label(section.sceneType || section.id || "Scene"))}</div>
          <h2>${escapeHtml(resolveHeadline(section))}</h2>
          <p>${escapeHtml(section.vo || props.visualAction || "")}</p>
        </div>
        <div class="proof-system ${visual ? "has-visual" : ""}">
          ${visual ? `<img class="screen" src="${escapeHtml(visual)}" alt="" />` : renderProofCards(chips)}
        </div>
        <div class="motion-note">${escapeHtml(props.visualAction || props.motionMode || "")}</div>
      </div>
    `;

    return sectionEl;
  }

  function renderProofCards(chips) {
    const cards = chips.length
      ? chips
      : [
          ["Input", "Context enters"],
          ["System", "Judgment happens"],
          ["Output", "A clearer state appears"],
        ];

    return cards
      .map(([k, v]) => `<div class="proof-card"><strong>${escapeHtml(k)}</strong><span>${escapeHtml(v)}</span></div>`)
      .join("");
  }

  function resolveHeadline(section) {
    const props = section.sceneProps || {};
    return props.kineticPhrase || props.tagline || props.headline || props.visualAction || section.vo || label(section.id || "Scene");
  }

  function resolveVisual(props) {
    if (typeof props.screen === "string") return asset(props.screen);
    if (typeof props.finalImage === "string") return asset(props.finalImage);
    if (Array.isArray(props.screens) && props.screens.length) {
      const first = props.screens[0];
      if (typeof first === "string") return asset(first);
      if (first && typeof first.src === "string") return asset(first.src);
    }
    return null;
  }

  function buildTimeline(target, renderMode, duration) {
    const tl = gsap.timeline({ paused: true });

    if (renderMode === "design-thumbnail") {
      tl.from(".design-rule", { scaleX: 0, transformOrigin: "left center", duration: 0.5, ease: "power3.out" }, 0);
      tl.from(".eyebrow", { opacity: 0, y: 18, duration: 0.45, ease: "power3.out" }, 0.15);
      tl.from("h1", { opacity: 0, y: 28, duration: 0.55, ease: "power3.out" }, 0.28);
      tl.from("p", { opacity: 0, y: 18, duration: 0.45, ease: "power3.out" }, 0.45);
      tl.from(".palette span", { opacity: 0, y: 12, stagger: 0.06, duration: 0.25, ease: "power2.out" }, 0.7);
      return tl;
    }

    target.querySelectorAll(".scene").forEach((scene) => {
      const start = Number(scene.getAttribute("data-start") || 0);
      const sceneDuration = Number(scene.getAttribute("data-duration") || 1);
      const outAt = Math.max(start + sceneDuration - 0.55, start + 0.3);
      const driftDuration = Math.max(0.6, sceneDuration - 0.8);

      tl.from(scene, { opacity: 0, duration: 0.25, ease: "power1.out" }, start);
      tl.from(scene.querySelector(".scene-copy"), { opacity: 0, y: 34, duration: 0.55, ease: "power3.out" }, start + 0.12);
      tl.from(scene.querySelectorAll(".proof-card, .screen"), { opacity: 0, y: 24, scale: 0.985, stagger: 0.08, duration: 0.5, ease: "power3.out" }, start + 0.35);
      tl.from(scene.querySelector(".motion-note"), { opacity: 0, y: 12, duration: 0.4, ease: "power2.out" }, start + 0.7);
      tl.to(scene.querySelector(".scene-copy"), { x: 28, duration: driftDuration, ease: "none" }, start + 0.45);
      tl.to(scene.querySelector(".proof-system"), { y: -34, duration: driftDuration, ease: "none" }, start + 0.45);
      tl.to(scene, { opacity: 0, y: -18, duration: 0.45, ease: "power2.in" }, outAt);
    });

    tl.to({}, { duration: Math.max(0.1, duration - tl.duration()) }, tl.duration());
    return tl;
  }

  function asset(value) {
    if (!value) return "";
    if (/^(https?:|data:|blob:)/.test(value)) return value;
    const clean = value.replace(/^\/+/, "");
    const normalized = clean.startsWith("public/") ? clean.replace(/^public\//, "") : clean;
    const prefix = location.pathname.includes("/compositions/") ? "../public/" : "public/";
    return prefix + normalized;
  }

  function sanitizeId(value) {
    return String(value).toLowerCase().replace(/[^a-z0-9_-]+/g, "-").replace(/^-|-$/g, "") || "scene";
  }

  function label(value) {
    return String(value)
      .replace(/[-_]+/g, " ")
      .replace(/\b\w/g, (char) => char.toUpperCase());
  }

  function escapeHtml(value) {
    return String(value ?? "")
      .replace(/&/g, "&amp;")
      .replace(/</g, "&lt;")
      .replace(/>/g, "&gt;")
      .replace(/"/g, "&quot;")
      .replace(/'/g, "&#039;");
  }
})();
