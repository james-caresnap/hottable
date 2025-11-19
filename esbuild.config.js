const path = require('path')
const rails = require('esbuild-rails')

const config = {
  entryPoints: ["application.js"],
  bundle: true,
  outdir: path.join(process.cwd(), "app/assets/builds"),
  absWorkingDir: path.join(process.cwd(), "app/javascript"),
  plugins: [rails()],
}

async function build() {
  if (process.argv.includes("--watch")) {
    const context = await require("esbuild").context(config)
    await context.watch()
    console.log("Watching for changes...")
  } else {
    await require("esbuild").build(config)
  }
}

build().catch(() => process.exit(1))
