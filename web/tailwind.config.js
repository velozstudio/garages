/** @type {import('tailwindcss').Config} */
export default {
  content: ["./index.html", "./src/**/*.{js,ts,jsx,tsx}"],
  theme: {
    extend: {
      colors: {
        veloz: {
          white: "#F6F6FD",
          primary: "#4560F1",
          neutral: {
            900: "#191A23",
            700: "#252635",
            500: "#2E2F40",
            200: "#5C5E72",
          },
        },
      },
    },
  },
  plugins: [],
};
