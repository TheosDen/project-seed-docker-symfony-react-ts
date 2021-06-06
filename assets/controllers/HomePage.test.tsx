import * as React from 'react'
import * as renderer from 'react-test-renderer'
import HomePage from './HomePage'

it('HomePage renders correctly', () => {
  const tree = renderer
    .create(<HomePage />)
    .toJSON()
  expect(tree).toMatchSnapshot()
})
