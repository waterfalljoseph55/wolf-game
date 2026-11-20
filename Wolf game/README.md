# A Wolf's Calling

A game about a wolf on the hunt, built in Godot 4.

## What's here

| File | What it is |
|---|---|
| `project.godot` | The Godot project. Open this folder in Godot 4. |
| `cutscenes/intro.tscn` | The opening cutscene scene. It is the main scene, so it plays first. |
| `cutscenes/intro.gd` | Plays the intro video and soundtrack, handles hold-to-skip, then loads `next_scene`. |
| `intro_audio.wav` | The intro soundtrack (82 s). Second 0 is the moment the intro starts. |
| `moonlight-hollow.html` | The 3D intro itself. Open it in a browser to watch or record it. |

## Adding the intro video

1. Open `moonlight-hollow.html` in a browser and record it with OBS (video only), starting when you click **Begin**.
2. Convert the recording to Godot's video format:
   ```
   ffmpeg -i intro.mp4 -t 80 -an -c:v libtheora -q:v 8 cutscenes/intro.ogv
   ```
3. Open the project in Godot. The intro scene picks up `cutscenes/intro.ogv` automatically and plays `intro_audio.wav` alongside it.
4. Select the `Intro` node and set **Next Scene** to your menu or first level.

## Intro timeline

| Time | Moment |
|---|---|
| 0:13 | The wolf appears in the bushes |
| 0:17.4 | The chase starts |
| 0:41 | Slow-motion log jump |
| 0:44–0:59 | Arrows fly in |
| 1:01.4 | The takedown |
| 1:14 | The howl |
| 1:17.6 | Title appears |
