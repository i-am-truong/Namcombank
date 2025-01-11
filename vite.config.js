import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
  plugins: [react()],
  server: {
    port: 3000,
  },
  resolve: {
    alias: {
      '@': '/src',
      '@public': '/public',
      // Thêm đường dẫn đến folder front-end mới
      '@frontend': '/frontend',
    },
  },
})