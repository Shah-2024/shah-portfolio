import { ref } from 'vue'
import { apiFetch } from '../lib/apiClient'

const _personal = ref(null)
let _fetched = false

export function usePersonal() {
  async function fetchPersonal() {
    if(_fetched) return
    const data = await apiFetch('/api/personal')
    if(data){ _personal.value = data; _fetched = true }
  }
  return { personal: _personal, fetchPersonal}
}

