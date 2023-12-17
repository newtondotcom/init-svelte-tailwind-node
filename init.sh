#!/bin/bash

# Check if a project name argument is provided
if [ -z "$1" ]; then
  echo "Please provide a project name as an argument."
  exit 1
fi

# Create a Svelte project
npx create-svelte@latest "$1"
cd "$1"

# Install required packages
yarn add tailwindcss postcss autoprefixer

# Initialize Tailwind CSS
yarn tailwindcss init -p

# Create tailwind.config.js
cat <<EOL > tailwind.config.js
/** @type {import('tailwindcss').Config} */
export default {
  content: ['./src/**/*.{html,js,svelte,ts}'],
  theme: {
    extend: {}
  },
  plugins: []
};
EOL

# Create src/app.css
echo "@tailwind base;\n@tailwind components;\n@tailwind utilities;" > src/app.css

# Replace "adapter-auto" with "adapter-node" in svelte.config.js
sed -i 's/adapter-auto/adapter-node/g' svelte.config.js

# Install @sveltejs/adapter-node
yarn add @sveltejs/adapter-node

# Create GitHub Actions directories
mkdir -p .github/workflows/
