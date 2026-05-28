import { ref } from 'vue'
import { apiFetch } from '../lib/apiClient'

const _skillGroups = ref([])
let _fetched = false

export function useSkills() {
  async function fetchSkills() {
    if (_fetched) return
    const data = await apiFetch('/api/skills')
    if (data) { _skillGroups.value = data; _fetched = true }
  }
  return { skillGroups: _skillGroups, fetchSkills }
}