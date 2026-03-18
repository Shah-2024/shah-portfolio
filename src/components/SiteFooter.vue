<template>
  <footer class="footer">
    <div class="container footer-inner">
      <span class="footer-brand">Shah Tahmid</span>
      <div class="footer-links">
        <a :href="personal?.github_url"   target="_blank" rel="noopener">GitHub</a>
        <a :href="personal?.linkedin_url" target="_blank" rel="noopener">LinkedIn</a>
        <a :href="`mailto:${personal?.email}`">Email</a>
      </div>
      <span class="footer-copy">© {{ year }}</span>
    </div>
  </footer>
</template>

<script setup>
import { onMounted } from 'vue'
import { usePersonal } from '../composables/usePersonal'
const { personal, fetchPersonal } = usePersonal()
const year = new Date().getFullYear()
onMounted(fetchPersonal)
</script>

<style scoped>
.footer {
  border-top: 1px solid var(--border);
  padding: 2rem 0;
  margin-top: 6rem;
}
.footer-inner {
  display: flex;
  align-items: center;
  justify-content: space-between;
  flex-wrap: wrap;
  gap: 1rem;
}
.footer-brand {
  font-family: var(--font-display);
  font-size: 1rem;
  font-weight: 500;
  color: var(--text);
}
.footer-links {
  display: flex;
  gap: 2rem;
}
.footer-links a {
  font-family: var(--font-body);
  font-size: 0.75rem;
  letter-spacing: 0.1em;
  text-transform: uppercase;
  color: var(--text-3);
  text-decoration: none;
  transition: color 0.2s;
}
.footer-links a:hover { color: var(--text); }
.footer-copy {
  font-family: var(--font-body);
  font-size: 0.75rem;
  color: var(--text-4);
}
</style>
