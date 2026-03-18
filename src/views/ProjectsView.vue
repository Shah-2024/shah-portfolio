<template>
  <main class="projects-page">
    <div class="container">

      <!-- PAGE HEADER -->
      <div class="page-header">
        <p class="eyebrow fade-up">Work</p>
        <h1 class="page-title fade-up" style="animation-delay:0.1s">Projects.</h1>
        <p class="page-desc fade-up" style="animation-delay:0.2s">
          A collection of engineering, development, and personal builds —
          spanning hardware, embedded systems, web, and everything in between.
        </p>
      </div>

      <!-- FILTER TABS -->
      <div class="filter-tabs fade-up" style="animation-delay:0.3s">
        <button
          v-for="tab in tabs"
          :key="tab.value"
          class="filter-tab"
          :class="{ active: activeTab === tab.value }"
          @click="activeTab = tab.value"
        >
          {{ tab.label }}
          <span class="tab-count">{{ tabCount(tab.value) }}</span>
        </button>
      </div>

      <div class="divider"></div>

      <!-- PROJECT CARDS -->
      <div v-if="loading" class="cards-grid">
        <div class="project-card skeleton" v-for="n in 4" :key="n">
          <div class="sk-cover"></div>
          <div class="sk-body">
            <div class="sk-line w40"></div>
            <div class="sk-line w80"></div>
            <div class="sk-line w60"></div>
          </div>
        </div>
      </div>

      <div v-else class="cards-grid">
        <article
          class="project-card"
          v-for="project in filteredProjects"
          :key="project.id"
        >
          <!-- Cover image / placeholder -->
          <div class="card-cover" :style="coverStyle(project.section)">
            <span class="card-section-label eyebrow">{{ sectionLabel(project.section) }}</span>
            <span class="badge badge-warm" v-if="project.status === 'in-progress'">In Progress</span>
          </div>

          <!-- Body -->
          <div class="card-body">
            <div class="card-meta">
              <span class="card-number eyebrow">{{ project.number }}</span>
            </div>
            <h2 class="card-title">{{ project.title }}</h2>
            <p class="card-desc">{{ project.description }}</p>
            <div class="card-tags">
              <span class="tag" v-for="tag in project.tags" :key="tag">{{ tag }}</span>
            </div>
            <div class="card-links">
              <a
                v-if="project.github_link"
                :href="project.github_link"
                target="_blank"
                rel="noopener"
                class="card-link"
              >
                GitHub →
              </a>
              <a
                v-if="project.live_link"
                :href="project.live_link"
                target="_blank"
                rel="noopener"
                class="card-link muted"
              >
                Live ↗
              </a>
              <span v-if="!project.github_link && !project.live_link" class="card-link-none">
                Hardware build
              </span>
            </div>
          </div>
        </article>
      </div>

    </div>
  </main>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { useProjects } from '../composables/useProjects'

const { all, loading, fetchProjects } = useProjects()
onMounted(fetchProjects)

const activeTab = ref('all')

const tabs = [
  { label: 'All',         value: 'all' },
  { label: 'Engineering', value: 'engineering' },
  { label: 'Web & Dev',   value: 'web' },
  { label: 'Self',        value: 'self' },
]

function tabCount(val) {
  if (val === 'all') return all.value.length
  return all.value.filter(p => p.section === val).length
}

const filteredProjects = computed(() => {
  if (activeTab.value === 'all') return all.value
  return all.value.filter(p => p.section === activeTab.value)
})

// Distinct warm tones per section — no images yet
const coverColors = {
  engineering: 'linear-gradient(135deg, #e8e0d4 0%, #d6cbbf 100%)',
  web:         'linear-gradient(135deg, #dce8e0 0%, #c4d9cc 100%)',
  self:        'linear-gradient(135deg, #e4dde8 0%, #d0c6d9 100%)',
}
function coverStyle(section) {
  return { background: coverColors[section] || coverColors.engineering }
}

function sectionLabel(section) {
  return { engineering: 'Engineering', web: 'Web & Dev', self: 'Personal' }[section] || section
}
</script>

<style scoped>
.projects-page { padding-bottom: 6rem; }

.page-header {
  padding: 4rem 0 3rem;
  max-width: 680px;
}
.page-title {
  font-family: var(--font-display);
  font-size: clamp(3rem, 7vw, 5.5rem);
  font-weight: 300;
  letter-spacing: -0.02em;
  line-height: 1;
  color: var(--text);
  margin: 1rem 0 1.5rem;
}
.page-desc {
  font-size: 1rem;
  color: var(--text-2);
  line-height: 1.75;
  max-width: 520px;
}

/* FILTER TABS */
.filter-tabs {
  display: flex;
  gap: 0;
  margin-bottom: 2rem;
  flex-wrap: wrap;
}
.filter-tab {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.6rem 1.4rem;
  font-family: var(--font-body);
  font-size: 0.78rem;
  font-weight: 400;
  letter-spacing: 0.08em;
  text-transform: uppercase;
  background: transparent;
  color: var(--text-3);
  border: 1px solid var(--border);
  border-right: none;
  cursor: pointer;
  transition: all 0.2s;
}
.filter-tab:last-child { border-right: 1px solid var(--border); }
.filter-tab:hover { color: var(--text); background: var(--bg-alt); }
.filter-tab.active { background: var(--text); color: var(--bg); border-color: var(--text); }
.filter-tab.active + .filter-tab { border-left-color: var(--text); }

.tab-count {
  font-size: 0.65rem;
  opacity: 0.6;
}

/* CARDS GRID */
.cards-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(340px, 1fr));
  gap: 1px;
  background: var(--border);
  border: 1px solid var(--border);
  margin-top: 2rem;
}

.project-card {
  background: var(--surface);
  display: flex;
  flex-direction: column;
  transition: background 0.2s;
}
.project-card:hover { background: var(--bg); }

.card-cover {
  height: 180px;
  display: flex;
  align-items: flex-end;
  justify-content: space-between;
  padding: 1.2rem 1.5rem;
}

.card-section-label { color: var(--text-3); }

.card-body { padding: 1.8rem 1.8rem 2rem; flex: 1; display: flex; flex-direction: column; }

.card-meta { margin-bottom: 0.5rem; }
.card-number { color: var(--text-4); }

.card-title {
  font-family: var(--font-display);
  font-size: 1.3rem;
  font-weight: 400;
  color: var(--text);
  line-height: 1.3;
  margin-bottom: 0.9rem;
}

.card-desc {
  font-size: 0.85rem;
  color: var(--text-3);
  line-height: 1.7;
  margin-bottom: 1.2rem;
  flex: 1;
}

.card-tags { display: flex; flex-wrap: wrap; gap: 0.35rem; margin-bottom: 1.5rem; }

.card-links { display: flex; gap: 1.2rem; align-items: center; margin-top: auto; }

.card-link {
  font-family: var(--font-body);
  font-size: 0.75rem;
  font-weight: 500;
  letter-spacing: 0.08em;
  text-transform: uppercase;
  color: var(--text);
  text-decoration: none;
  border-bottom: 1px solid var(--border-dark);
  padding-bottom: 1px;
  transition: border-color 0.2s;
}
.card-link:hover { border-color: var(--text); }
.card-link.muted { color: var(--text-3); }
.card-link-none {
  font-family: var(--font-body);
  font-size: 0.72rem;
  color: var(--text-4);
  letter-spacing: 0.06em;
}

/* Skeleton */
.project-card.skeleton { pointer-events: none; }
.sk-cover { height: 180px; background: var(--bg-alt); animation: shimmer 1.4s ease infinite; }
.sk-body { padding: 1.8rem; display: flex; flex-direction: column; gap: 0.8rem; }
.sk-line { height: 13px; background: var(--border); border-radius: 2px; animation: shimmer 1.4s ease infinite; }
.sk-line.w40 { width: 40%; }
.sk-line.w60 { width: 60%; }
.sk-line.w80 { width: 80%; }
@keyframes shimmer { 0%,100%{opacity:0.5} 50%{opacity:1} }

@media (max-width: 768px) {
  .cards-grid { grid-template-columns: 1fr; }
  .filter-tab { padding: 0.5rem 1rem; }
}
</style>
