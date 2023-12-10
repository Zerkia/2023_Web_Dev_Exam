/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["../views/*.php"],
  theme: {
    extend: {
      fontFamily: {
        'roboto': ['Roboto', 'sans-serif'],
      },      
    },
  },
  plugins: [],
  darkMode: 'class'
}