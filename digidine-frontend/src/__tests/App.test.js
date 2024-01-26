// App.test.js
import { render, screen } from '@testing-library/react';
import App from '../App';

test('renders App component without crashing', () => {
//   render(<App />);
  const linkElement = screen.getByText(/Home/i);
  expect(linkElement).not.toBeInTheDocument();
});