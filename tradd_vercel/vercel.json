{
  "version": 2,
  "outputDirectory": "public",
  "functions": {
    "api/**/*.js": {
      "runtime": "@vercel/node@3.0.0"
    }
  },
  "rewrites": [
    { "source": "/api/(.*)", "destination": "/api/$1" },
    { "source": "/(.*)", "destination": "/index.html" }
  ]
}
