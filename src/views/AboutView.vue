<template>
  <main class="about-page">
    <div class="container">

      <div class="page-header">
        <p class="eyebrow fade-up">About</p>
        <h1 class="page-title fade-up" style="animation-delay:0.1s">About Me.</h1>
      </div>

      <!-- BIO + DETAILS -->
      <div class="about-grid fade-up" style="animation-delay:0.2s">
        <div class="about-bio">
          <p class="bio-lead">
            Versatile Electrical Engineering student at Stony Brook University with a
            passion for building intelligent systems that bridge the gap between
            hardware and software.
          </p>
          <p class="bio-body">
            My work spans industrial IoT, embedded systems, full-stack web development,
            and systems programming in Rust and C++. I'm drawn to projects that demand
            both rigorous engineering thinking and creative problem solving — from
            programming OPC UA servers on Raspberry Pi for real SCADA integration,
            to building production web apps with modern stacks.
          </p>
          <p class="bio-body">
            Outside of engineering I explore Islamic theology and metaphysics,
            work on personal builds and setup projects, and freelance in web development.
            I'm currently seeking Summer 2025 internships in automation, controls,
            or embedded systems engineering.
          </p>
          <div class="bio-actions">
            <RouterLink to="/contact" class="btn btn-dark">Get In Touch</RouterLink>
            <RouterLink to="/projects" class="btn btn-outline">View Projects</RouterLink>
          </div>
        </div>

        <div class="about-details">
          <div class="detail-block">
            <p class="eyebrow detail-label">Education</p>
            <p class="detail-value">B.S. Electrical Engineering</p>
            <p class="detail-sub">Stony Brook University · Expected May 2027</p>
            <p class="detail-sub mt">Relevant: Digital Logic, Signals & Systems, Control Systems, DSP</p>
          </div>
          <div class="detail-block">
            <p class="eyebrow detail-label">Certifications</p>
            <p class="detail-value">AWS Certified Cloud Practitioner</p>
            <p class="detail-sub">Cloud fundamentals, architecture, service deployment</p>
          </div>
          <div class="detail-block">
            <p class="eyebrow detail-label">Location</p>
            <p class="detail-value">Queens, New York</p>
            <p class="detail-sub">U.S. Permanent Resident</p>
          </div>
        </div>
      </div>

      <div class="divider" style="margin: 4rem 0"></div>

      <!-- SKILLS -->
      <div class="skills-section fade-up" style="animation-delay:0.3s">
        <p class="eyebrow" style="margin-bottom:2rem">Technical Proficiencies</p>
        <div class="skills-grid" v-if="skillGroups.length">
          <div class="skill-col" v-for="group in skillGroups" :key="group.id">
            <p class="skill-col-title">{{ group.title }}</p>
            <ul class="skill-list">
              <li v-for="skill in group.skills" :key="skill">{{ skill }}</li>
            </ul>
          </div>
        </div>
        <div v-else class="skills-grid">
          <div class="skill-col" v-for="n in 5" :key="n">
            <div class="sk-line w50" style="margin-bottom:1rem"></div>
            <div class="sk-line w80" v-for="m in 5" :key="m" style="margin-bottom:0.6rem"></div>
          </div>
        </div>
      </div>

      <div class="divider" style="margin: 4rem 0"></div>

      <!-- EXPERIENCE -->
      <div class="experience-section fade-up" style="animation-delay:0.35s">
        <p class="eyebrow" style="margin-bottom:2rem">Experience & Leadership</p>
        <div class="exp-list">
          <div class="exp-row">
            <div class="exp-left">
              <p class="exp-role">Volunteer Coordinator</p>
              <p class="exp-org">Quantum Foundation</p>
            </div>
            <div class="exp-right">
              <p class="exp-detail">Managing 50+ participant wellness programs</p>
            </div>
          </div>
          <div class="exp-row">
            <div class="exp-left">
              <p class="exp-role">Freelance Web Developer</p>
              <p class="exp-org">Independent</p>
            </div>
            <div class="exp-right">
              <p class="exp-detail">React · Vue · Supabase · Full-stack applications</p>
            </div>
          </div>
        </div>
      </div>

    </div>
  </main>
</template>

<script setup>
import { onMounted } from 'vue'
import { RouterLink } from 'vue-router'
import { useSkills } from '../composables/useSkills'

const { skillGroups, fetchSkills } = useSkills()
onMounted(fetchSkills)
</script>

<style scoped>
.about-page { padding-bottom: 6rem; }

.page-header { padding: 4rem 0 3rem; }
.page-title {
  font-family: var(--font-display);
  font-size: clamp(3rem, 7vw, 5.5rem);
  font-weight: 300;
  letter-spacing: -0.02em;
  line-height: 1;
  margin: 1rem 0 0;
}

/* BIO GRID */
.about-grid {
  display: grid;
  grid-template-columns: 1fr 320px;
  gap: 6rem;
  align-items: start;
}

.bio-lead {
  font-family: var(--font-display);
  font-size: 1.45rem;
  font-weight: 300;
  font-style: italic;
  color: var(--text);
  line-height: 1.5;
  margin-bottom: 1.5rem;
}
.bio-body {
  font-size: 0.95rem;
  color: var(--text-2);
  line-height: 1.8;
  margin-bottom: 1.2rem;
}
.bio-actions { display: flex; gap: 1rem; margin-top: 2.5rem; flex-wrap: wrap; }

.detail-block { margin-bottom: 2rem; padding-bottom: 2rem; border-bottom: 1px solid var(--border); }
.detail-block:last-child { border-bottom: none; }
.detail-label { margin-bottom: 0.6rem; display: block; }
.detail-value { font-family: var(--font-display); font-size: 1.15rem; font-weight: 400; color: var(--text); margin-bottom: 0.3rem; }
.detail-sub { font-size: 0.82rem; color: var(--text-3); line-height: 1.5; }
.detail-sub.mt { margin-top: 0.5rem; }

/* SKILLS */
.skills-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(160px, 1fr));
  gap: 2.5rem;
}
.skill-col-title {
  font-family: var(--font-body);
  font-size: 0.72rem;
  font-weight: 500;
  letter-spacing: 0.14em;
  text-transform: uppercase;
  color: var(--text-3);
  margin-bottom: 1rem;
  padding-bottom: 0.75rem;
  border-bottom: 1px solid var(--border);
}
.skill-list { list-style: none; }
.skill-list li {
  font-size: 0.85rem;
  color: var(--text-2);
  padding: 0.3rem 0;
  display: flex;
  align-items: center;
  gap: 0.5rem;
}
.skill-list li::before { content: '—'; color: var(--text-4); font-size: 0.7rem; }

/* EXPERIENCE */
.exp-list { display: flex; flex-direction: column; }
.exp-row {
  display: grid;
  grid-template-columns: 240px 1fr;
  gap: 3rem;
  padding: 1.5rem 0;
  border-bottom: 1px solid var(--border);
  align-items: start;
}
.exp-row:first-child { border-top: 1px solid var(--border); }
.exp-role { font-family: var(--font-display); font-size: 1.1rem; font-weight: 400; color: var(--text); margin-bottom: 0.2rem; }
.exp-org { font-size: 0.82rem; color: var(--text-3); }
.exp-detail { font-size: 0.9rem; color: var(--text-2); line-height: 1.6; padding-top: 0.2rem; }

/* Skeleton */
.sk-line { height: 12px; background: var(--border); border-radius: 2px; animation: shimmer 1.4s ease infinite; }
.sk-line.w50 { width: 50%; }
.sk-line.w80 { width: 80%; }
@keyframes shimmer { 0%,100%{opacity:0.5} 50%{opacity:1} }

@media (max-width: 900px) {
  .about-grid { grid-template-columns: 1fr; gap: 3rem; }
  .exp-row { grid-template-columns: 1fr; gap: 0.5rem; }
}
</style>
