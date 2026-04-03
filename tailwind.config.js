/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      colors: {
        primary: '#3B82F6',
        'primary-light': '#60A5FA',
        'primary-deep': '#1D4ED8',
        'bg-base': '#F0F7FF',
      },
    },
  },
  plugins: [],
}
