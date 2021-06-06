import * as React from 'react'
import * as renderer from 'react-test-renderer'
import LoginPage from './LoginPage'

it('LoginPage renders correctly', () => {
  const tree = renderer
    .create(<LoginPage />)
    .toJSON()
  expect(tree).toMatchSnapshot()
})
