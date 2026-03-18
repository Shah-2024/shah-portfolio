<template>
  <main class="contact-page">
    <div class="container">

      <div class="page-header">
        <p class="eyebrow fade-up">Contact</p>
        <h1 class="page-title fade-up" style="animation-delay:0.1s">Let's Talk.</h1>
        <p class="page-desc fade-up" style="animation-delay:0.2s">
          Whether you're looking for an EE intern, a freelance web developer,
          or just want to talk shop about embedded systems — reach out.
        </p>
      </div>

      <div class="contact-grid fade-up" style="animation-delay:0.3s">

        <!-- PRIMARY — EMAIL -->
        <a :href="`mailto:${personal?.email}`" class="contact-primary">
          <span class="eyebrow">Primary</span>
          <h2 class="contact-email">{{ personal?.email || 'tahmidshahmd@gmail.com' }}</h2>
          <span class="contact-cta">Send an email →</span>
        </a>

        <!-- SECONDARY LINKS -->
        <div class="contact-secondary">
          <a :href="personal?.github_url" target="_blank" rel="noopener" class="contact-link-row">
            <div class="contact-link-icon">GH</div>
            <div class="contact-link-body">
              <p class="contact-link-label eyebrow">GitHub</p>
              <p class="contact-link-value">{{ personal?.github_handle || 'github.com/Shah-2024' }}</p>
            </div>
            <span class="contact-link-arrow">→</span>
          </a>

          <a :href="personal?.linkedin_url" target="_blank" rel="noopener" class="contact-link-row">
            <div class="contact-link-icon">in</div>
            <div class="contact-link-body">
              <p class="contact-link-label eyebrow">LinkedIn</p>
              <p class="contact-link-value">{{ personal?.linkedin_handle || 'linkedin.com/in/shah-tahmid2026' }}</p>
            </div>
            <span class="contact-link-arrow">→</span>
          </a>

          <div class="contact-availability">
            <span class="avail-dot"></span>
            <div>
              <p class="avail-title">Open to opportunities</p>
              <p class="avail-sub">Internships · Freelance · Collaboration</p>
            </div>
          </div>
        </div>

      </div>

    </div>
  </main>
</template>

<script setup>
import { onMounted } from 'vue'
import { usePersonal } from '../composables/usePersonal'
const { personal, fetchPersonal } = usePersonal()
onMounted(fetchPersonal)
</script>

<style scoped>
.contact-page { padding-bottom: 6rem; }

.page-header { padding: 4rem 0 3rem; max-width: 600px; }
.page-title {
  font-family: var(--font-display);
  font-size: clamp(3rem, 7vw, 5.5rem);
  font-weight: 300;
  letter-spacing: -0.02em;
  line-height: 1;
  margin: 1rem 0 1.2rem;
}
.page-desc { font-size: 1rem; color: var(--text-2); line-height: 1.75; }

.contact-grid {
  display: grid;
  grid-template-columns: 1fr 400px;
  gap: 3rem;
  align-items: start;
  margin-top: 1rem;
}

/* PRIMARY */
.contact-primary {
  display: flex;
  flex-direction: column;
  gap: 1.2rem;
  padding: 3rem;
  border: 1px solid var(--border);
  background: var(--surface);
  text-decoration: none;
  color: inherit;
  transition: border-color 0.2s, background 0.2s;
}
.contact-primary:hover { border-color: var(--border-dark); background: var(--bg-alt); }

.contact-email {
  font-family: var(--font-display);
  font-size: clamp(1.3rem, 3vw, 2rem);
  font-weight: 300;
  color: var(--text);
  line-height: 1.2;
  word-break: break-all;
}

.contact-cta {
  font-family: var(--font-body);
  font-size: 0.8rem;
  font-weight: 500;
  letter-spacing: 0.1em;
  text-transform: uppercase;
  color: var(--text-3);
  transition: color 0.2s;
}
.contact-primary:hover .contact-cta { color: var(--text); }

/* SECONDARY */
.contact-secondary { display: flex; flex-direction: column; gap: 1px; background: var(--border); border: 1px solid var(--border); }

.contact-link-row {
  display: flex;
  align-items: center;
  gap: 1.2rem;
  padding: 1.4rem 1.5rem;
  background: var(--surface);
  text-decoration: none;
  color: inherit;
  transition: background 0.2s;
}
.contact-link-row:hover { background: var(--bg-alt); }

.contact-link-icon {
  width: 36px; height: 36px;
  border: 1px solid var(--border);
  display: flex; align-items: center; justify-content: center;
  font-family: var(--font-body);
  font-size: 0.68rem;
  font-weight: 500;
  color: var(--text-3);
  flex-shrink: 0;
}

.contact-link-body { flex: 1; }
.contact-link-label { display: block; margin-bottom: 0.2rem; }
.contact-link-value { font-family: var(--font-body); font-size: 0.85rem; color: var(--text); }

.contact-link-arrow { color: var(--text-4); font-size: 1rem; transition: transform 0.2s; }
.contact-link-row:hover .contact-link-arrow { transform: translateX(3px); color: var(--text); }

.contact-availability {
  display: flex;
  align-items: center;
  gap: 1rem;
  padding: 1.4rem 1.5rem;
  background: var(--surface);
}
.avail-dot {
  width: 8px; height: 8px;
  border-radius: 50%;
  background: #4caf78;
  flex-shrink: 0;
  animation: pulse 2.5s ease infinite;
}
@keyframes pulse { 0%,100%{opacity:1} 50%{opacity:0.4} }

.avail-title { font-size: 0.9rem; font-weight: 500; color: var(--text); margin-bottom: 0.2rem; }
.avail-sub { font-size: 0.78rem; color: var(--text-3); }

@media (max-width: 900px) {
  .contact-grid { grid-template-columns: 1fr; }
  .contact-primary { padding: 2rem; }
}
</style>
