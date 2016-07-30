export const setUser = makeAction('SET_USER')

export function loadState({dispatch, state}, loaded) {
    dispatch(Mutation.LOAD_STATE, loaded)
}

function makeAction (type) {
  return ({ dispatch }, ...args) => dispatch(type, ...args)
}
