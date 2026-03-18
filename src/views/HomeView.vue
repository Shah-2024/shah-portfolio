<template>
  <main class="home">

    <!-- HERO -->
    <section class="hero container">
      <div class="hero-text">
        <p class="eyebrow fade-up" style="animation-delay:0s">
          Electrical Engineering · Stony Brook University · Class of 2027
        </p>
        <h1 class="hero-heading fade-up" style="animation-delay:0.1s">
          I'm Shah —<br />
          <em>Engineer.</em><br />
          Builder. Developer.
        </h1>
        <p class="hero-desc fade-up" style="animation-delay:0.2s">
          Bridging hardware and software. I build intelligent systems — from
          industrial IoT and embedded hardware to full-stack web applications.
          Based in Queens, NY.
        </p>
        <div class="hero-actions fade-up" style="animation-delay:0.3s">
          <RouterLink to="/projects" class="btn btn-dark">View Projects</RouterLink>
          <RouterLink to="/about"    class="btn btn-outline">About Me</RouterLink>
        </div>
      </div>
      <div class="hero-visual fade-up" style="animation-delay:0.2s">
        <div class="hero-card">
          <div class="hero-card-inner">
            <span class="hero-card-label eyebrow">Currently</span>
            <p class="hero-card-status">Open to internships</p>
            <p class="hero-card-sub">Summer 2025 · Automation · Controls · Embedded</p>
          </div>
          <div class="hero-card-divider"></div>
          <div class="hero-card-inner">
            <span class="hero-card-label eyebrow">Location</span>
            <p class="hero-card-status">Queens, New York</p>
          </div>
          <div class="hero-card-divider"></div>
          <div class="hero-card-inner">
            <span class="hero-card-label eyebrow">Stack</span>
            <div class="hero-stack">
              <span v-for="s in stack" :key="s" class="tag">{{ s }}</span>
            </div>
          </div>
        </div>
      </div>
    </section>

    <div class="divider container-full"></div>

    <!-- FEATURED PROJECTS -->
    <section class="featured container">
      <div class="section-header">
        <p class="eyebrow">Selected Work</p>
        <h2 class="section-title">Featured Projects</h2>
      </div>

      <div v-if="loading" class="project-list">
        <div class="project-row skeleton" v-for="n in 3" :key="n">
          <div class="sk-line w30"></div>
          <div class="sk-line w60"></div>
          <div class="sk-line w15"></div>
        </div>
      </div>

      <div v-else class="project-list">
        <RouterLink
          to="/projects"
          class="project-row"
          v-for="(project, i) in featured"
          :key="project.id"
        >
          <span class="project-index eyebrow">{{ String(i + 1).padStart(2, '0') }}</span>
          <div class="project-row-body">
            <h3 class="project-row-title">{{ project.title }}</h3>
            <div class="project-row-tags">
              <span class="tag" v-for="tag in project.tags.slice(0, 3)" :key="tag">{{ tag }}</span>
            </div>
          </div>
          <div class="project-row-right">
            <span class="badge badge-warm" v-if="project.status === 'in-progress'">In Progress</span>
            <span class="project-arrow">→</span>
          </div>
        </RouterLink>
      </div>

      <div class="featured-footer">
        <RouterLink to="/projects" class="btn btn-outline">All Projects</RouterLink>
      </div>
    </section>

    <div class="divider container-full"></div>

    <!-- ABOUT STRIP -->
    <section class="about-strip container">
      <div class="about-strip-text">
        <p class="eyebrow">About</p>
        <h2 class="section-title">
          Versatile EE student with a passion for building intelligent systems
          that bridge the gap between hardware and software.
        </h2>
        <RouterLink to="/about" class="btn btn-outline" style="margin-top: 2.5rem">
          Read More
        </RouterLink>
      </div>
      <div class="about-strip-skills">
        <div class="skill-pill-group" v-for="group in quickSkills" :key="group.label">
          <p class="skill-pill-label eyebrow">{{ group.label }}</p>
          <div class="skill-pills">
            <span class="tag" v-for="s in group.items" :key="s">{{ s }}</span>
          </div>
        </div>
      </div>
    </section>

  </main>
</template>

<script setup>
import { computed, onMounted } from 'vue'
import { RouterLink } from 'vue-router'
import { useProjects } from '../composables/useProjects'

const { all, loading, fetchProjects } = useProjects()
onMounted(fetchProjects)

const featured = computed(() => all.value.slice(0, 4))

const stack = ['Python', 'C/C++', 'Rust', 'Vue', 'Supabase', 'Arduino', 'FPGA']

const quickSkills = [
  { label: 'Hardware', items: ['PCB Design', 'Raspberry Pi', 'STM32', 'Arduino'] },
  { label: 'Software', items: ['Python', 'C++', 'Rust', 'Vue / React'] },
  { label: 'Tools',    items: ['MATLAB', 'LTSpice', 'Altium', 'Git'] },
]
</script>

<style scoped>
.home { padding-bottom: 0; }

/* HERO */
.hero {
  display: grid;
  grid-template-columns: 1fr 380px;
  gap: 5rem;
  align-items: start;
  padding-top: 5rem;
  padding-bottom: 6rem;
}

.hero-heading {
  font-family: var(--font-display);
  font-size: clamp(3.2rem, 6vw, 5.5rem);
  font-weight: 300;
  line-height: 1.05;
  letter-spacing: -0.01em;
  color: var(--text);
  margin: 1.5rem 0 1.8rem;
}
.hero-heading em {
  font-style: italic;
  color: var(--text-2);
}

.hero-desc {
  max-width: 460px;
  font-size: 1rem;
  color: var(--text-2);
  line-height: 1.75;
  margin-bottom: 2.5rem;
}

.hero-actions { display: flex; gap: 1rem; flex-wrap: wrap; }

/* Hero card */
.hero-card {
  border: 1px solid var(--border);
  background: var(--surface);
  position: sticky;
  top: calc(var(--nav-h) + 2rem);
}
.hero-card-inner { padding: 1.5rem 1.8rem; }
.hero-card-label { display: block; margin-bottom: 0.5rem; }
.hero-card-status {
  font-family: var(--font-display);
  font-size: 1.25rem;
  font-weight: 400;
  color: var(--text);
  line-height: 1.3;
}
.hero-card-sub {
  font-size: 0.8rem;
  color: var(--text-3);
  margin-top: 0.3rem;
  line-height: 1.5;
}
.hero-card-divider { height: 1px; background: var(--border); }
.hero-stack { display: flex; flex-wrap: wrap; gap: 0.4rem; margin-top: 0.5rem; }

/* FEATURED PROJECTS */
.featured { padding-top: 5rem; padding-bottom: 5rem; }

.section-header {
  display: flex;
  align-items: baseline;
  justify-content: space-between;
  margin-bottom: 3rem;
  flex-wrap: wrap;
  gap: 1rem;
}

.section-title {
  font-family: var(--font-display);
  font-size: clamp(1.8rem, 3.5vw, 2.8rem);
  font-weight: 300;
  letter-spacing: -0.01em;
  color: var(--text);
}

.project-list { display: flex; flex-direction: column; }

.project-row {
  display: grid;
  grid-template-columns: 48px 1fr auto;
  align-items: center;
  gap: 2rem;
  padding: 1.8rem 0;
  border-bottom: 1px solid var(--border);
  text-decoration: none;
  color: inherit;
  transition: background 0.2s;
}
.project-row:first-child { border-top: 1px solid var(--border); }
.project-row:hover { background: var(--bg-alt); margin: 0 -2rem; padding: 1.8rem 2rem; }

.project-index { color: var(--text-4); flex-shrink: 0; }

.project-row-title {
  font-family: var(--font-display);
  font-size: 1.35rem;
  font-weight: 400;
  color: var(--text);
  margin-bottom: 0.6rem;
}
.project-row-tags { display: flex; flex-wrap: wrap; gap: 0.35rem; }

.project-row-right {
  display: flex;
  align-items: center;
  gap: 1rem;
  flex-shrink: 0;
}
.project-arrow {
  font-size: 1.1rem;
  color: var(--text-4);
  transition: transform 0.2s, color 0.2s;
}
.project-row:hover .project-arrow { transform: translateX(4px); color: var(--text); }

/* Skeleton */
.project-row.skeleton { pointer-events: none; }
.sk-line { height: 14px; background: var(--border); animation: shimmer 1.4s ease infinite; border-radius: 2px; }
.sk-line.w30 { width: 30%; }
.sk-line.w60 { width: 60%; }
.sk-line.w15 { width: 15%; }
@keyframes shimmer { 0%,100%{opacity:0.5} 50%{opacity:1} }

.featured-footer { margin-top: 3rem; }

/* ABOUT STRIP */
.about-strip {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 6rem;
  align-items: start;
  padding-top: 5rem;
  padding-bottom: 6rem;
}

.about-strip-text .section-title {
  font-size: clamp(1.4rem, 2.5vw, 1.9rem);
  line-height: 1.4;
  margin-top: 1rem;
  color: var(--text-2);
  font-style: italic;
}

.about-strip-skills {
  display: flex;
  flex-direction: column;
  gap: 2rem;
  padding-top: 0.5rem;
}

.skill-pill-label { margin-bottom: 0.7rem; display: block; }
.skill-pills { display: flex; flex-wrap: wrap; gap: 0.4rem; }

.container-full { margin: 0; }

@media (max-width: 900px) {
  .hero { grid-template-columns: 1fr; gap: 3rem; }
  .hero-visual { order: -1; }
  .about-strip { grid-template-columns: 1fr; gap: 3rem; }
  .project-row { grid-template-columns: 36px 1fr auto; gap: 1rem; }
}
</style>
