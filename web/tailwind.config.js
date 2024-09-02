/** @type {import('tailwindcss').Config} */



// --primary: #2c2c2c;
// --secondary: #424050;
// --accent: #8685ef;

// --text-primary: #faf7ff;
// --text-secondary: #2b2b2b;
import { join, resolve } from 'path'
import { skeleton } from '@skeletonlabs/tw-plugin'
import forms from '@tailwindcss/forms'

export default {
    darkMode: 'class',
    content: [
        "./index.html",
        "./src/**/*.{svelte,js,ts,jsx,tsx}",
        join(
          resolve('@skeletonlabs/skeleton'), 
          '../**/*.{html,js,svelte,ts}')
      ],
  theme: {
    extend: {},
  },
  plugins: [
    forms,
    skeleton({
      themes: { preset: [ {name: "wintry", enhancements: true} ]}
    })
  ],
}

